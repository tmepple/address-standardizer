/**ADDRESS_STANDARDIZER***************************************************
 *
 * Address Standardizer
 *      A collection of C++ classes for parsing street addresses
 *      and standardizing them for the purpose of Geocoding.
 *
 * Copyright 2016 Stephen Woodbridge <woodbri@imaptools.com>
 *
 * This is free software; you can redistribute and/or modify it under
 * the terms of the MIT License. Please file LICENSE for details.
 *
 ***************************************************ADDRESS_STANDARDIZER**/

#ifndef ADDRESS_STANDARDIZER_H
#define ADDRESS_STANDARDIZER_H


typedef struct {
   char *building;
   char *house_num;
   char *predir;
   char *qual;
   char *pretype;
   char *name;
   char *suftype;
   char *sufdir;
   char *ruralroute;
   char *extra;
   char *city;
   char *prov;
   char *country;
   char *postcode;
   char *box;
   char *unit;
   char *pattern;
} STDADDR;


typedef struct
{
    void *lex_obj;
    void *gmr_obj;
}
STANDARDIZER;


typedef struct
{
    int pat;
    int seq;
    char *word;
    char *inclass;
    char *attached;
} TOKENS;

typedef struct
{
    char * tokens;
    double score;
    double nrules;
} MTOKEN;


#ifdef __cplusplus
extern "C" {
#endif


STDADDR *std_standardize_ptrs(
    char *address_in,
    void *grammar_ptr,
    void *lexicon_ptr,
    char *locale_in,
    char *filter_in,
    char **err_msg
);


STDADDR *std_standardize(
    char *address_in,
    char *grammar_in,
    char *lexicon_in,
    char *locale_in,
    char *filter_in,
    char **err_msg
);


TOKENS *std_parse_address_ptrs(
    char *address_in,
    void *lexicon_ptr,
    char *locale_in,
    char *filter_in,
    int  *nrec,
    char **err_msg
);


TOKENS *std_parse_address(
    char *address_in,
    char *lexicon_in,
    char *locale_in,
    char *filter_in,
    int  *nrec,
    char **err_msg
);


MTOKEN *std_match_address(
    char *address_in,
    char *grammar_in,
    char *lexicon_in,
    char *locale_in,
    char *filter_in,
    int  *nrec,
    char **err_msg
);

void tokens_free( TOKENS *tokens, int nrec );

void *getGrammarPtr( char *grammar_in, char **err_msg );

void freeGrammarPtr( void *ptr );

void *getLexiconPtr( char *lexicon_in, char **err_msg );

void freeLexiconPtr( void *ptr );

char *getGrammarMd5( void *ptr );

char *getLexiconMd5( void *ptr );

char *getMd5( char *text );

char * serialize_lexicon(
    char *lexicon_in,
    char **err_msg
);

#ifdef __cplusplus
}
#endif

#endif
