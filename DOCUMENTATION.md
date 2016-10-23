# Address Standardizer

Author: Stephen Woodbridge

## What Is It?

The Address Standardizer is a set of C++ classes designed to deal with the
problem of standardizing street addresses for the purpose of geocoding.
Geocoding is the process of matching an address to a reference set of streets.
In more general terms, this library can be used for record linkage between data
dataset be matching a record in one data set to record(s) in another data set.

Some of the key design features are:

* Support for UTF8 data to support multiple languages
* Human readable Lexicon and Grammar file
* Support for splitting attached street types like in German
* Wrappers to make it callable as a PostgreSQL stored procedure
* C++ OO Class structure

It is **not** intended to be a CASS Address correction or standardizing tool.
If you do not know what this means then read on.

## Why You Might Care?

If you need to build a geocoder or a record linking application then this is a
key component that can help in that task. Additionally, if you need to change
the underlying data that is being matched for example by adding a new
country to the standardizer or adding an new reference set, then this document
will help explain the how it works and what you can do to make those changes.

## How Does It Work?

It parses a string into tokens and assigns an input classification to each one
using a lexicon. It then matches the stream of input tokens against a grammar
to decide how to best map this token stream to a set of output classification
based on the grammar so we can understand the structure of the text.

There are a few main modules in the code the work together to accomplish this:
Lexicon, Tokenizer, Grammar, Search classes that work together to take and
address, parse it into tokens, then search the grammar for a match to tokens.
The end result is that based on the matching we can reclassify the input tokens
into a standardized stream of output tokens.

### Example Problem

Here is an example address that might get parsed to the following input tokens.
Then after matching the input tokens to a grammar, we can identify each token
by its output classification to understand how to map the words in the address
to components of an address.

    Address: 11 Radcliffe Rd North Chelmsford MA 01863 USA
    Input Tokens:  NUMBER WORD TYPE DIRECT WORD PROV NUMBER NATION
    Output Tokens: HOUSE STREET SUFTYP CITY CITY PROV POSTAL NATION

In the above example the address is Tokenized using the Lexicon to help classify
the input tokens. Next we search the Grammar looking for a match to the input
tokens. If we match the grammar, the input tokens are reclassified by the
Grammar rules to the output tokens.

This is a very simple example to get the idea across. More detailed
explanations follow.

### Lexicon Class

The Lexicon class is responsible for:

* loading data into the lexicon
* classifying tokens
* working with the Tokenizer

Currently data is loaded from text files or PostgreSQL tables when wrapped into
a stored procedure. The file format for the data is explained below. The
lexicon can contain words or phrases and each has a list of possible
classifications. For example the word **NORTH** could be a direction indicator
when used in "11 North Main St" but is just a part of a city name in "North
Chelmsford". In the former we might classify **NORTH** as **DIRECT** and in the
later just as **WORD**. You will see this in the file format example below. The
Lexicon also support defining abbreviations and/or common misspellings that you
might want to be able to recognize and classify.

### Tokenizer Class

The Tokenizer class is responsible for parsing the string into tokens using the
lexicon to recognize words and phrases, to split attached words and work with
the lexicon to classify the input tokens. The input is a string and the output
is a vector of tokens.

### Grammar Class

The Grammar class is responsible for loading a grammar and building the
internal structures to hold it. A grammar is stored as a collection of named Rules.

### Search Class

The Search class extends a grammar and provides the methods for matching a stream of input tokens to a grammar. It uses a recursive search algorithm to match the input tokens to the grammar.

### Lexicon File Format

These files are required to be in UTF8 data.

The following is a sample of lines from the **lex-usa.txt** file

    LEXICON:    lex-usa.txt ENG en_US
    LEXENTRY:   #   APT UNITH   DETACH
    LEXENTRY:   9   9   NUMBER  DETACH
    LEXENTRY:   90  90  NUMBER  DETACH
    LEXENTRY:   90TH    90TH    WORD,ORD    DETACH
    LEXENTRY:   9TH 9TH WORD,ORD    DETACH
    LEXENTRY:   AK  Alaska  PROV    DETACH
    LEXENTRY:   AL  Alabama PROV    DETACH
    LEXENTRY:   ALLEE   ALY TYPE    DET_SUF
    LEXENTRY:   ALLEY   ALY TYPE    DET_SUF
    LEXENTRY:   ALLY    ALY TYPE    DET_SUF
    LEXENTRY:   ALY ALY TYPE    DET_SUF

The file is tab separated columns because you can have a phrase with spaces
within a field.

    LEXICON:	<filename>	<lang>	<locale>
    LEXENTRY:	<word>	<stdword>	<InClass::Type>	<InClass::AttachType>

where:

* &lt;filename> - not used, but handy for managing a large number of files
* &lt;lang> - not used, see **inclass.h** for a list of language codes
* &lt;locale> - the UTF8 locale for this data used to normalize and uppercase strings.
* &lt;word> - the word or phrase that represents this entry.
* &lt;stdword> - the standardized word or phrase for this entry.
* &lt;InClass::Type> - a comma separated list of InClass::Type(s) for this entry.
* &lt;InClass::AttachType> - a comma separated list of possible attachment types.

See **inclass.h** for the list of <InClass::Type> and <InClass::AttachType> values. **DETACH** is used represent no attachments. In lex-german.txt you will find a good example of attachments with this entry:

    LEXENTRY:   STRASSE STRASSE TYPE    ATT_SUF,DET_PRE,DET_SUF
    LEXENTRY:   STRAßE  STRASSE TYPE    ATT_SUF,DET_PRE,DET_SUF

These entries represent the German word for STREET and you can see from the attachment list that this entry can be:

* ATT_SUF - Attached at the suffix of a street name like: Mühlenstrasse
* DET_PRE - Prefix detached from the street name
* DET_SUF - Suffix detached from the street name like: Lange Strasse

Not included in the list above are:

* ATT_PRE - An attached prefix
* DETACH - No attachment (this is not listed inclass.h).

Lexicon files can be compiled and these compiled files load 10 times faster
than the original lexicon data files. In most cases, the code will accept
either form of the lexicon data. If you load the sample data files from the
sql it will create a compiled version of the lexicon in the ``clexicon``
column. If the format of the compiled lexicon changes, you will get an error
message indicating that you need to re-compile the lexicon.

### Grammar File Format

In general, the grammar files should be built to work with specific lexicons
and these need to be build based on a specific dataset and/or country. While
there may be a lot of commonality between data sets for a specific country,
each vendor will have their own idiosyncratic terms and phrases that need to be
recognized and classified.

The grammar is made up of a collection of rules. There are two types of rules:

1. meta rule that refers to other rules
2. terminal rules that refer to a partial stream of <InClass::Type>

The system currently requires the root rule to be named "ADDRESS", beyond that you can name your rules using only letters, numbers and '_'. References to rules require the preceeding '@' character, like "@STREET_ADDRESS" below to refer to the "[STREET_ADDRESS]" rule. Comment line begin with a '#' character and blank lines are ignored.

The file syntax is:

    comment := '#' TEXT{0+} NEWLINE
    file := rule_group{1+} | comment{0+} | NEWLINE{0+}
    rule_group := meta_group | terminal_group
    identifier := ( LETTER | NUMBER | '_' ){1+}
    header := '[ADDRESS]'{1} | '[' identifier ']'
    meta_group := header meta_rules
    terminal_group := header terminal_rules
    meta_reference := '@' identifier
    meta_rules := ( meta_reference+ NEWLINE ){1+}
    rule := InClass::Type{n} '->' OutClass::Type{n} '->' FLOAT
    terminal_rules := ( rule NEWLINE ){1+}

The meta rules look like the follow:

    [ADDRESS]
    @STREET_ADDRESS @MACRO
    @PLACENAME @STREET_ADDRESS @MACRO

The "[ADDRESS]" is the rule name. The "@<name>" is a reference to another rule.
This "[ADDRESS]" rule is saying an address is composed of matching the
"STREET_ADDRESS" rule followed by matching the "MACRO" rule. Or by matching the
"PLACENAME" rule followed by the "STREET_ADDRESS" rule followed by the "MACRO"
rule. So the grammar can be broken into convenient pieces and chained together
using the meta rules.

For example, "STREET_ADDRESS" might also refer to another meta rule like:

    [STREET_ADDRESS]
    @HOUSE_NUMBER @STREET_NAME
    @HOUSE_NUMBER @STREET_NAME @SECOND_UNIT
    @STREET_NAME @HOUSE_NUMBER
    @STREET_NAME @HOUSE_NUMBER @SECOND_UNIT

The "STREET_NAME" rule is a simple example of a terminal rule:

    [STREET_NAME]
    TYPE WORD   -> PRETYP STREET -> 0.3
    WORD TYPE   -> STREET SUFTYP -> 0.3

Terminal rules are constructed as:

    <InClass::Type> list '->' <OutClass::Type> list '->' <score>

the number of items in two lists **must** be the same. The <score> can be
considered the probability for this rule. When a string is parsed into tokens,
any given token might have multiple classification. We enumerate all the
possible combinations of token classes and then match each to the grammar. We
might get multiple matches and the score allow us to select the best possible
match.

The purpose of these rules is to take a stream of input tokens and map them to
appropriate output tokens. The goal is to understand that a given token like
WORD in the input really belongs to the street name or maybe the city name,
etc.

So reviewing the original example:

    Address: 11 Radcliffe Rd North Chelmsford MA 01863 USA
    Input Tokens:  NUMBER WORD TYPE DIRECT WORD PROV NUMBER NATION
    Output Tokens: HOUSE STREET SUFTYP CITY CITY PROV POSTAL NATION

In this example, the first WORD token gets mapped to the STREET token and
the second WORD token get mapped to the CITY token. This allow us to match
"Radcliffe" against street names and Chelmsford against city names. 

### Existing Lexicons and Grammars

The project has an collection of lexicons for various countries in Europe,
United States and Canada. (See the **data/sample** directory). These lexicons
are only a starting place for users and will need to be adapted for your
specific needs.

Likewise there are starter grammars in the **data/grammar/** directory.

Files ending in **.txt|.lex|.gmr** can be used with the file loader classes and files ending in **.sql** can be loaded as tables in the database and passed into the stored procedure interfaces in PostgreSQL.

## Performance Considerations

For each address that we need to standardize, we need both the lexicon and the
grammar objects. These are expensive to read and construct each time we need
them. We have implemented two features the can significantly improve
performance around this issue.

### Compile the Lexicon

It takes time to load a lexicon, especially if it is large, but if you compile
the lexicon using ``as_compile_lexicon`` and save it, then supplying the
compiled lexicon instead of the source lexicon saves about 66% of the time to
load the lexicon. If you load the sample lexicons and grammars, we create a
``clexicon`` column and compile the lexicon into that. Or you could do
something like:

```
update as_config set clexicon = as_compile_lexicon( lexicon );
```

which would compile or recompile all the lexicons in the ``as_config`` table.

### Query-Level Caching of Lexicon and Grammar objects

We implemented Query-Level Caching of Lexicon and Grammar objects to speed up
standardizing a whole table. You will not see any benefit on one-off queries
but if you construct your queries like the follow, there is a significant
performance boost.

For this example, assume that we have a table ``test_addresses`` with a column ``address`` and we want to standardize the text in ``address`` into a new table ``standardized_addresses`` that contains ``id`` from ``test_addresses``, the standardized fields followed by the ``test_addresses.address`` field.

```
-- before PostgreSQL 9.3 use a query like this
create table standardized_addresses as
with tmp as (select a.id, address, as_standardize(
                 address,
                 grammar,
                 clexicon,
                 'en_US',
                 filter) as std
             from as_config cfg, test_addresses a
            where cfg.countrycode='us')
select id, (std).*, address
  from tmp
 order by id;

-- PostgreSQL 9.3+ use a query like this
select a.id, std.*, address
  from test_addresses as a,
       as_config cfg,
       LATERAL as_standardize(
            address,
            grammar,
            clexicon,
            'en_US',
            filter
        ) as std
 where cfg.countrycode='us'
 order by a.id;

```

You can get a little more creative if your ``test_addresses`` table looks like
this and you are working with addresses from multiple countries. Given that the
``as_config`` looks like the following.

```
CREATE TABLE as_config
(
  id serial NOT NULL PRIMARY KEY,
  countrycode character(2),
  countryname text,
  dataset text,
  lexicon text,
  clexicon text,
  grammar text,
  filter text
);
```

You might create your ``test_addresses`` table like:

```
CREATE TABLE test_addresses
(
    id serial NOT NULL PRIMARY KEY,
    address text,
    locale text,
    countrycode character(2)
);
```

Now ``test_addresses.countrycode`` can join on ``as_config.countrycode`` and in
this case we can now use multiple lexicons and grammars where each is
appropriate to address record getting standardized, using queries like:

```
-- before PostgreSQL 9.3 use a query like this
create table standardized_addresses as
with tmp as (select a.id, address, as_standardize(
                 address,
                 grammar,
                 clexicon,
                 a.locale,
                 filter) as std
             from as_config cfg, test_addresses a
            where a.countrycode=cfg.countrycode
            order by a.countrycode)
select id, address, (std).* from tmp;

-- PostgreSQL 9.3+ use a query like this
select a.id, address, std.*
  from test_addresses as a,
       as_config cfg,
       LATERAL as_standardize(
            address,
            grammar,
            clexicon,
            a.locale,
            filter
        ) as std
 where a.countrycode=cfg.countrycode
 order by a.countrycode;

```

In this example, we ``order by a.countrycode`` so we only build the Lexicon and
Grammar once for the country. There are multiple slots in the cache, but it is
possible to overwrite a slot to make room for a new incoming slot in the cache
if it fills up and this prevents that from potentially becoming a problem.

You might also notice that the ``locale`` is save with the address and not the `Lexicon``. The reason is that many countries are multilingual so the specific interpertation of an address needs to be based on its locale. The Lexicon may contain words and phrases for multiple languages as does the US lexicon that has some Spanish and French words used in addresses in the US.


