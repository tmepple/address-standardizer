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

#ifndef GRAMMAR_H
#define GRAMMAR_H

#include <map>
#include <vector>
#include <string>
#include <iostream>
#include <stdexcept>
#include <boost/serialization/version.hpp>
#include <boost/serialization/vector.hpp>
#include <boost/serialization/map.hpp>

#include "md5.h"
#include "inclass.h"
#include "outclass.h"
#include "metasection.h"
#include "rulesection.h"

class Grammar
{
    friend std::ostream &operator<<(std::ostream &ss, const Grammar &g);

private:
    friend class boost::serialization::access;

    template<class Archive>
    void load(Archive & ar, const unsigned int version) {
        if ( version < 1 )
            throw std::runtime_error("Re-compile-your-grammar");
        ar >> metas_;
        ar >> rules_;
        ar >> sectionIndex_;
        ar >> md5_;
    }

    template<class Archive>
    void save(Archive & ar, const unsigned int /* version */) const {
        ar << metas_;
        ar << rules_;
        ar << sectionIndex_;
        ar << md5_;
    }

    BOOST_SERIALIZATION_SPLIT_MEMBER()

public:

    typedef enum {
        CHECK_FATAL = -1,
        CHECK_OK    =  0,
        CHECK_WARN  =  1
    } Status;

    Grammar( const Grammar& ) = default;
    explicit Grammar( const std::string &file );
    explicit Grammar( const char *grammar_in );
    explicit Grammar( std::istream &is );

    void initialize( std::istream &is );
//    void check();
//    void check( std::string section, std::string key );
    void updatePointers();

    Status status() const { return status_; };
    std::string issues() const { return issues_; } ;
    const char *getMd5() { return md5_.c_str(); };


private:

    typedef enum {
        ISMETA,
        ISRULE,
        UNKNWN
    } RuleType;


protected:

    std::vector<MetaSection> metas_;
    std::vector<RuleSection> rules_;
    std::map<std::string,unsigned long int> sectionIndex_;
    std::string md5_;

    // temp storage for analysis and checking of grammar
    std::string issues_;
    std::map<std::string, int> references_;
    std::set<std::string> checked_;
    Status status_;

};

// Added md5_ in version 1
BOOST_CLASS_VERSION(Grammar, 1)

#endif
