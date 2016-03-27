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

#include <boost/regex.hpp>
#include <boost/regex/icu.hpp>
#include "metarule.h"


MetaRule::MetaRule( const std::string &line ) {
    std::string token;
    std::stringstream buffer(line);

    auto re_meta = boost::make_u32regex( "@([\\w_]+)" );
    boost::smatch what;

    std::string::const_iterator start, end;
    start = line.begin();
    end   = line.end();

    while ( boost::u32regex_search( start, end, what, re_meta ) ) {
        if (what[1].first < what[1].second)
            refs_.push_back( SectionPtr( std::string( what[1].first, what[1].second ) ) );
        start = what[0].second;
    }
}



std::ostream &operator<<(std::ostream &ss, const MetaRule &r) {
    bool first = true;
    for ( auto e = r.begin(); e != r.end(); e++ ) {
        if (not first)
            ss << " ";
        ss << "@" << e->name();
        first = false;
    }

    return ss;
}

