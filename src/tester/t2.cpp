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


#include "inclass.h"
#include "lexicon.h"
#include "token.h"
#include "tokenizer.h"
#include "utils.h"
#include "grammar.h"
#include "search.h"

#include <iostream>
#include <string>
#include <vector>

int main(int ac, char* av[]) {

    if (ac < 4) {
        std::cerr << "Usage: t2 lex.txt grammar.txt 'address to parse'\n";
        return EXIT_FAILURE;
    }

    std::string lfile = av[1];
    std::string gfile = av[2];
    std::string str = av[3];

//    std::cout << "Lexicon: '" << file << "'\n";
    std::cout << "Address: '" << str << "'\n";

    // Normalize and UPPERCASE the input string
    UErrorCode errorCode;
    std::string nstr = Utils::normalizeUTF8( str, errorCode );
    std::string Ustr = Utils::upperCaseUTF8( nstr, "en" );

    std::cout << "Normalized: '" << nstr << "'\n";
    std::cout << "UpperCase: '" << Ustr << "'\n";

    Lexicon lex("test-lex", lfile);
//    std::cout << lex << "\n";
//    std::cout << "Lexicon regex: '" << lex.regex() <<"'\n\n";
//    std::cout << "Lexicon attachedRegex: '" << lex.attachedRegex() <<"'\n\n";

    Tokenizer tokenizer( lex );
    tokenizer.addFilter( InClass::PUNCT );
    tokenizer.addFilter( InClass::SPACE );
    tokenizer.addFilter( InClass::DASH );

    std::vector<std::vector<Token> > phrases = tokenizer.getTokens( Ustr );

    for ( const auto phrase : phrases ) {
        std::cout << "-------------------------------\n";
        for ( const auto tok : phrase )
            std::cout << tok << "\n";
    }
    std::cout << "-------------------------------\n";

    try {
        Grammar G( gfile );

        switch (G.status() ) {
            case Grammar::CHECK_FATAL:
                std::cout << "FATAL loading grammar: " << G.issues() << "\n";
                return(1);
            case Grammar::CHECK_WARN:
                std::cout << "WARNING loading grammar: " << G.issues() << "\n";
                break;
            case Grammar::CHECK_OK:
                break;
        }

        Search S( G );

        float bestCost = -1.0;
        auto best = S.searchAndReclassBest( phrases, bestCost );
        if ( bestCost < 0.0 ) {
            std::cout << "#### Failed to find a match (searchAndReclassBest)(" << bestCost << ")\n";
            return(1);
        }

        // get the appropriate standard terms and
        // print out the reclassified tokens
        std::cout << "bestCost: " << bestCost << "\n";
        for (auto &token : best) {
            lex.standardize( token );
            std::cout << token << "\n";
        }

    }
    catch (std::runtime_error& e) {
        std::cout << "Runtime Error: " << e.what() << "\n";
        return(1);
    }
    catch (...) {
        std::cout << "Error: Unknown exception caught!\n";
        return(1);
    }
    return EXIT_SUCCESS;
}
