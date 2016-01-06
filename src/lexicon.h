/*HEADER
*HEADER*/

#ifndef LEXICON_H
#define LEXICON_H

#include <map>
#include <deque>
#include <string>
#include <iostream>

#include "inclass.h"
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
    void langAsString( std::string lang );
    void locale( std::string locale ) { locale_ = locale; };

    void insert( const LexEntry &le );
    void remove( const LexEntry &le );

    // operators
    friend std::ostream &operator<<(std::ostream &ss, const Lexicon &lex);

private:

    bool isInAttached( const std::string word ) const;

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
    std::deque<std::string> attached_;


};

#endif
