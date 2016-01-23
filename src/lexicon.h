/*HEADER
*HEADER*/

#ifndef LEXICON_H
#define LEXICON_H

#include <map>
#include <deque>
#include <string>
#include <iostream>
#include <boost/regex.hpp>

#include "inclass.h"
#include "token.h"
#include "lexentry.h"

class Lexicon
{
protected:

public:
    // constructors
    Lexicon();
    Lexicon(std::string name);
    Lexicon(std::string name, std::string file);

    // getters
    std::string name() const { return name_; };
    InClass::Lang lang() const { return lang_; };
    std::string langAsString() const { return InClass::asString(lang_); };
    std::string langAsName() const { return InClass::asName(lang_); };
    std::string locale() const { return locale_; };

    std::deque<LexEntry> find( const std::string key );

    // mutators
    void name( const std::string name ) { name_ = name; };
    void lang( const InClass::Lang lang ) { lang_ = lang; };
    void lang( const std::string lang ) { lang_ = InClass::asLang( lang ); };
    void locale( const std::string locale ) { locale_ = locale; };

    void insert( const LexEntry &le );
    void remove( const LexEntry &le );

    std::string regex();
    std::string regexPrefixAtt();
    std::string regexSuffixAtt();

    // operators
    friend std::ostream &operator<<(std::ostream &ss, const Lexicon &lex);

    void classify( Token& token, InClass::Type typ );

private:

    std::string escapeRegex( const std::string &str);

    struct lexcomp {
        bool operator() (const std::string &lhs, const std::string &rhs) const {
            return lhs<rhs;
        }
    };


private:
    std::string name_;
    InClass::Lang lang_;
    std::string locale_;
    std::map <std::string, std::deque<LexEntry>, lexcomp> lex_;
    std::string regex_;
    std::string regexPrefix_;
    std::string regexSuffix_;


};

#endif
