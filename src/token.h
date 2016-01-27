/*HEADER*
*HEADER*/

#ifndef TOKEN_H
#define TOKEN_H

#include <string>
#include <set>
#include <vector>

#include "inclass.h"
#include "outclass.h"
#include "token.h"

class Token {

public:

    Token();
    Token(std::string text);

    // getters
    std::string text() const { return text_; };
    std::string stdtext() const { return stdtext_; };
    std::set<InClass::Type> inclass() const { return inclass_; };
    std::set<InClass::AttachType> attached() const { return attached_; };
    OutClass::Type outclass() const { return outclass_; };

    std::string attachedAsString() const { return InClass::asString( attached_ ); };
    std::string inclassAsString() const { return InClass::asString( inclass_ ); };
    std::string outclassAsString() const { return OutClass::asString( outclass_ ); };
    bool isInClass( std::set<InClass::Type> test ) const;
    bool isInClassEmpty() const { return inclass_.empty(); };

    static std::vector< std::vector<InClass::Type> > enumerate( std::vector<Token> tokens );

    // mutators
    void text(std::string text) { text_ = text; };
    void stdtext(std::string stdtext) { stdtext_ = stdtext; };
    void inclass(InClass::Type inclass) { inclass_.insert( inclass ); };
    void inclass(std::set<InClass::Type> inclass) { inclass_ = inclass; };
    void attached(InClass::AttachType attached) { attached_.insert( attached ); };
    void attached(std::set<InClass::AttachType> attached) { attached_ = attached; };
    void outclass(OutClass::Type outclass) { outclass_ = outclass; };

    // operators

    friend std::ostream &operator<<(std::ostream &ss, const Token &token);

private:

    int inSize() const { return inclass_.size(); };
    InClass::Type in(int i) const;


private:
    std::string text_;
    std::string stdtext_;
    std::set<InClass::Type> inclass_;
    OutClass::Type outclass_;
    std::set<InClass::AttachType> attached_;

};

#endif

