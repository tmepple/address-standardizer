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

#ifndef SEARCH_H
#define SEARCH_H

#include <string>
#include <vector>

#include "inclass.h"
#include "outclass.h"
#include "token.h"
#include "rule.h"
#include "grammar.h"

class SearchPath {
public:
    std::vector<Rule> rules;
    std::vector<std::string> next;
    std::vector<InClass::Type> remaining;
};

typedef std::vector<SearchPath> SearchPaths;



class Search : Grammar
{
public:

    Search( const Grammar &G ) : Grammar( G ) {};

    SearchPaths search( std::vector<Token> &phrase ) const;

    SearchPaths search( const std::string &grammarNode, std::vector<Token> &phrase ) const;

    bool reclassTokens(std::vector<Token> &tokens, const SearchPath &path ) const;

    SearchPath searchAndReclassBest( std::vector<Token> &phrase, float &cost ) const;

    SearchPath searchAndReclassBest( std::vector<std::vector<Token> > &phrases, float &cost ) const;

private:

    SearchPaths match( const std::string &name, const SearchPaths &paths ) const;
    SearchPaths match( const std::string &name, const SearchPath &path ) const;
    SearchPaths matchNext( const SearchPaths &paths ) const;
    SearchPaths matchNext( const SearchPath &path ) const;
    SearchPath matchRule( const Rule &r, const SearchPath &path ) const;


};

#endif
