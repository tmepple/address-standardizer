/**ADDRESS_STANDARDIZER**
**ADDRESS_STANDARDIZER**/

#ifndef SECTIONPTR_H
#define SECTIONPTR_H

#include <string>
#include <stdexcept>

//#include "metasection.h"
//#include "rulesection.h"

class MetaSection;
class RuleSection;

class SectionPtr
{
public:

    SectionPtr(std::string name) : name_( name ) , mptr_( NULL ) , rptr_( NULL ) {};

    MetaSection * mptr() const { return mptr_; };
    RuleSection * rptr() const { return rptr_; };
    const std::string & name() const { return name_; };

    void mptr( MetaSection * ptr ) { mptr_ = ptr; };
    void rptr( RuleSection * ptr ) { rptr_ = ptr; };

private:

    std::string name_;
    MetaSection * mptr_;
    RuleSection * rptr_;

};

#endif

