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

#ifndef TOKENIZER_H
#define TOKENIZER_H

#include <string>
#include <vector>
#include <set>
#include <boost/regex.hpp>
#include <boost/regex/icu.hpp>

#include "token.h"
#include "lexicon.h"

class Tokenizer {

public:
    Tokenizer(Lexicon& in_lex) : lex_(in_lex) {};
    std::vector<Token> getTokens(std::string str);

    std::set<InClass::Type> filter() const { return filter_; };
    Lexicon lexicon() const { return lex_; };

    void filter(std::set<InClass::Type> filter) { filter_ = filter; };
    void lexicon(Lexicon& lex) { lex_ = lex; };
    void addFilter(InClass::Type filter) { filter_.insert(filter); };
    void removeFilter(InClass::Type filter) { filter_.erase(filter_.find(filter)); };
    void clearFilter() { filter_.clear(); };

private:
    Lexicon& lex_;
    std::set<InClass::Type> filter_;

};

#endif

