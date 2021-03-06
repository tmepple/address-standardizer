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

// The following two defines are required by the Boost unit test framework
// to create the necessary testing support. These defines must be placed
// before the inclusion of the boost headers.
//
// The first define provides a name for our Boost test module.
//
// The second of these defines is used to indicate that we are building a
// unit test module that will link dynamically with Boost. If you are using
// a static library version of Boost, this define must be deleted. (or
// in this case commented out)
//
// and include the test headers

#define BOOST_TEST_MODULE GrammarTestModule

#define BOOST_TEST_DYN_LINK
#include <boost/test/unit_test.hpp>

#include <fstream>
#include <string>
#include <stdexcept>
#include "grammar.h"

// The two relevant Boost namespaces for the unit test framework are:
using namespace boost;
using namespace boost::unit_test;

// Provide a name for our suite of tests. This statement is used to bracket
// our test cases.
BOOST_AUTO_TEST_SUITE(GrammarTestSuite)

// The structure below allows us to pass a test initialization object to
// each test case. Note the use of struct to default all methods and member
// variables to public access.
struct TestFixture
{
    TestFixture() {
        // Put test initialization here, the constructor will be called
        // prior to the execution of each test case
        //printf("Initialize test\n");
    }
    ~TestFixture() {
        // Put test cleanup here, the destructor will automatically be
        // invoked at the end of each test case.
        //printf("Cleanup test\n");
    }
    // Public test fixture variables are automatically available to all test
    // cases. Don’t forget to initialize these variables in the constructors
    // to avoid initialized variable errors.
    
    std::ostringstream os;

};

// Define a test case. The first argument specifies the name of the test.
// Take some care in naming your tests. Do not reuse names or accidentally use
// the same name for a test as specified for the module test suite name.
//
// The second argument provides a test build-up/tear-down object that is
// responsible for creating and destroying any resources needed by the
// unit test
BOOST_FIXTURE_TEST_CASE(Grammar_Fatal_1, TestFixture)
{
    BOOST_CHECK_THROW( Grammar G("fatal1.grammar"),  std::runtime_error );
}

BOOST_FIXTURE_TEST_CASE(Grammar_Fatal_2, TestFixture)
{
    BOOST_CHECK_THROW( Grammar G( "fatal2.grammar" ), std::runtime_error );
}

BOOST_FIXTURE_TEST_CASE(Grammar_Warn, TestFixture)
{

    BOOST_CHECK_THROW( Grammar G( "warn.grammar" ), std::runtime_error );
}

BOOST_FIXTURE_TEST_CASE(Grammar_Good, TestFixture)
{
    BOOST_CHECK_NO_THROW( Grammar G( "good.grammar" ) );
    Grammar G( "good.grammar" );
    //printf("status: %d\n", G.status());
    BOOST_CHECK(G.status() == Grammar::CHECK_OK);
    //printf("'%s'\n", G.issues().c_str());
    BOOST_CHECK(G.issues() == "");

    os.str("");
    os << G;

    std::string expect = 
        "[ADDRESS]\n"
        "@AB @CD @EF\n"
        "@A @BC @DE\n"
        "@CD @EF\n\n"
        "[A]\n"
        "NUMBER -> BLDNG -> 0.5\n\n"
        "[AB]\n"
        "NUMBER WORD -> BLDNG HOUSE -> 0.5\n\n"
        "[BC]\n"
        "WORD TYPE -> HOUSE PREDIR -> 0.5\n\n"
        "[CD]\n"
        "TYPE QUALIF -> PREDIR QUALIF -> 0.5\n\n"
        "[DE]\n"
        "QUALIF ROAD -> QUALIF SUFTYP -> 0.5\n\n"
        "[EF]\n"
        "ROAD RR -> SUFTYP SUFDIR -> 0.5\n\n";

    //printf("GOT: '%s'\n", os.str().c_str());
    //printf("EXP: '%s'\n", expect.c_str());
    BOOST_CHECK(os.str() == expect);
}

// This must match the BOOST_AUTO_TEST_SUITE(ExampleTestSuite) statement
// above and is used to bracket our test cases.

BOOST_AUTO_TEST_SUITE_END()

