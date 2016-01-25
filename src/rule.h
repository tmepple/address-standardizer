/*HEADER*
*HEADER*/

#ifndef RULE_H
#define RULE_H

#include <vector>
#include <string>

#include "inclass.h"
#include "outclass.h"

class Rule
{
public:

    // constructors
    Rule( const Rule &rule ) = default;
    Rule() : score_(0.0) {};
    Rule( const std::string &line, const bool isMeta );

    // accessors
    bool isMeta() const { return meta_.size() > 0; };
    std::vector<std::string> meta() const { return meta_; };
    std::vector<InClass::Type> in() const { return inClass_; };
    std::vector<OutClass::Type> out() const { return outClass_; };
    float score() const { return score_; };
    bool isValid() const;

    // algorithms
    Rule concat( const Rule &r ) const;

    // operators
    inline Rule operator+( const Rule &rhs ) const { return concat( rhs ); };
    friend std::ostream &operator<<(std::ostream &ss, const Rule &r);

    // setters
    void clear();
    void pushMeta( const std::string &s );
    void pushIn( const InClass::Type t );
    void pushOut( const OutClass::Type t );
    void pushInOut( const InClass::Type in, const OutClass::Type out);

    void meta( const std::vector<std::string> &meta );
    void in( const std::vector<InClass::Type> &in );
    void out( const std::vector<OutClass::Type>  &out );
    void score( const float s );


private:

    std::vector<std::string> meta_;
    std::vector<InClass::Type> inClass_;
    std::vector<OutClass::Type> outClass_;
    float score_;

};

#endif
