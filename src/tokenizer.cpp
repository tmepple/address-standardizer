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

#include <vector>
#include <string>
#include <boost/algorithm/string/classification.hpp>
#include <boost/algorithm/string/split.hpp>

#include "tokenizer.h"
#include "utils.h"

void Tokenizer::removeFilter(InClass::Type filter) {
    auto it = filter_.find(filter);
    if ( it != filter_.end() )
        filter_.erase(it);
}


// splitTokens - uses the prefixAtt and suffixAtt regexes to split
// the string. we can end up with the following cases
// str: abcdefg
// case 1: abc ----     : prefix match
// case 2: ---- efg     : sufix match
// case 3: abc - efg    : prefix and suffix with middle left over
// case 4: abcd --- , --- defg  : prefix and suffix but overlapping
// case 5: abc defg     : prefix and suffix touching
// For case 3, we will return prefix, middle, suffix.

std::vector<Token> Tokenizer::splitToken( const Token &tok ) {
    std::vector<Token> outtokens;
    boost::smatch what;
    std::string str = tok.text();

    // if the token is mixed [0-9] and [A-Z]
    // then process it here
    if ( tok.isInClass( InClass::MIXED ) ) {
        // split mixed alpha digit tokens, eg:
        // 500W => 500 W or N123 => N 123 or I80 => I 80
        const char* replace( "$1 $2" );
        boost::u32regex re = boost::make_u32regex( std::string( "^(\\d+)([[:alpha:]\\p{L}])$" ) );
        std::string tmp = boost::u32regex_replace( str, re, replace );
        str = tmp;
        re = boost::make_u32regex( std::string( "\\<([[:alpha:]\\p{L}])(\\d+)\\>" ) );
        tmp = boost::u32regex_replace( str, re, replace );
        str = tmp;

        std::vector<std::string> words;
        boost::split(words, str, boost::is_any_of(" "), boost::token_compress_on);
        for ( const auto &e : words ) {
            Token ta( e );
            lex_.classify( ta, InClass::WORD );
            outtokens.push_back( ta );
        }
        return outtokens;
    }

    // a and b are prefix parts of str if matched
    // c and d are suffix parts of str if matched
    std::string a, b, c, d;

    boost::match_flag_type flags = boost::match_default;

    // could not get this to work with auto
    std::string::const_iterator start, end;

    std::string attached = "(" + lex_.regexPrefixAtt() + ")(.+)";
    if (attached.length() > 6) {
        boost::u32regex re = boost::make_u32regex( attached );
        // boost::u32regex_match can throw std::runtime_error if the
        // regex is too complex, we catch and and continue as if
        // we did not match
        try {
            start = str.begin();
            end   = str.end();
            if ( boost::u32regex_match( start, end, what, re, flags ) ) {
                a = std::string(what[1].first, what[1].second);
                b = std::string(what[2].first, what[2].second);
            }
        }
        catch (const std::runtime_error &e ) {
            // we might want to log e.what() while debugging
            return outtokens;
        };
    }

    attached = "(.+)(" + lex_.regexSuffixAtt() + ")";
    if (attached.length() > 6) {
        boost::u32regex re2 = boost::make_u32regex( attached );
        // boost::u32regex_match can throw std::runtime_error if the
        // regex is too complex, we catch and and continue as if
        // we did not match
        try {
            start = str.begin();
            end   = str.end();
            if ( boost::u32regex_match( start, end , what, re2, flags ) ) {
                c = std::string(what[1].first, what[1].second);
                d = std::string(what[2].first, what[2].second);
            }
        }
        catch (const std::runtime_error &e ) {
            // we might want to log e.what() while debugging
            return outtokens;
        };
    }

    // sort out the cases described above

    if ( a.size() > 0 ) {
        // case 1 and 5: prefix only or prefix touches suffix
        if ( d.size() == 0 or b.size() == d.size() ) {
            Token ta( a );
            lex_.classify( ta, InClass::WORD );
            outtokens.push_back( ta );
            Token tb( b );
            lex_.classify( tb, InClass::WORD );
            outtokens.push_back( tb );
        }
        // case 3: not overlapping
        else if ( d.size() > 0 and a.size() + d.size() < str.size() ) {
            Token ta( a );
            lex_.classify( ta, InClass::WORD );
            outtokens.push_back( ta );
            Token middle( str.substr( a.size(), str.size()-a.size()-d.size() ) );
            lex_.classify( middle, InClass::WORD );
            outtokens.push_back( middle );
            Token td( d );
            lex_.classify( td, InClass::WORD );
            outtokens.push_back( td );
        }
        // case 4: overlapping
        else if ( d.size() > 0 and a.size() + d.size() > str.size() ) {
            Token tc( c );
            lex_.classify( tc, InClass::WORD );
            outtokens.push_back( tc );
            Token td( d );
            lex_.classify( td, InClass::WORD );
            outtokens.push_back( td );
        }
    }
    // case 2: suffix only
    else if ( d.size() > 0 ) {
        Token tc( c );
        lex_.classify( tc, InClass::WORD );
        outtokens.push_back( tc );
        Token td( d );
        lex_.classify( td, InClass::WORD );
        outtokens.push_back( td );
    }

    return outtokens;
}


std::vector<Token> Tokenizer::getTokens( std::string str ) {

    // make sure the text is normalized and UUPERCASE
    std::string locale = lex_.locale();
    UErrorCode errorCode;
    std::string nstr = Utils::normalizeUTF8( str, errorCode );
    str = Utils::upperCaseUTF8( nstr, locale );

    // build the regex for identifying tokens
    std::string regex = "^\\s*(?!(?:\xe2\x80\x94)+)(" + lex_.regex() + "\\d+/\\d+|\\d+[,\\.]\\d+|\\d+|\\<[[:alpha:]]+\\>|[\\p{L}\\p{Nd}]+|[[:alpha:]\\d]+)([-&\\s\\|[:punct:]]+|\xe2\x80\x94|$)";

    boost::u32regex re = boost::make_u32regex( regex, boost::regex::icase );

    std::vector<Token> outtokens;

    boost::smatch what;
    boost::match_flag_type flags = boost::match_default;

    // could not get this to work with auto
    std::string::const_iterator start, end;
    start = str.begin();
    end   = str.end();

    while ( boost::u32regex_search( start, end, what, re ) ) {
        // fetch and create the token for the word or phrase
        if (what[1].first < what[1].second) {
            Token tok( std::string(what[1].first, what[1].second) );
            // token might classify as multiple types
            // or none, in which case make it a word
            lex_.classify(tok, InClass::WORD);
            if ( tok.inLex() ) {
                outtokens.push_back(tok);
            }
            else {
                auto toks = splitToken( tok );
                if ( toks.size() > 0 )
                    for ( const auto &t : toks )
                        outtokens.push_back( t );
                else
                    outtokens.push_back(tok);
            }
        }

        // create a token for the punctuation
        if (what[2].first < what[2].second) {
            Token punct( std::string(what[2].first, what[2].second) );
            lex_.classify(punct, InClass::PUNCT);
            outtokens.push_back(punct);
        }

        // break if there is nothing left
        if (start == end)
            break;

        // update search position
        start = what[0].second;

        // update flags
        flags |= boost::match_not_bob;
    }

    return applyFilter( outtokens );
}


std::vector<Token> Tokenizer::applyFilter( const std::vector<Token> &in ) {
    std::vector<Token> out;

    for (const auto &t : in )
        if (not t.isInClass(filter_))
            out.push_back( t );

    return out;
}
