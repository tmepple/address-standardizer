/*HEADER
*HEADER*/

#include <iostream>
#include <sstream>
#include <string>

#include "lexentry.h"
#include "inclass.h"
#include "lexicon.h"

// constructors

Lexicon::Lexicon() {
    name_ = "";
    lang_ = InClass::UNKNOWN;
    locale_ = "";
    lex_.clear();
}


Lexicon::Lexicon(std::string name) {
    name_ = name;
    lang_ = InClass::UNKNOWN;
    locale_ = "";
    lex_.clear();
}


Lexicon::Lexicon(std::string name, std::string file) {
    name_ = name;
    lang_ = InClass::UNKNOWN;
    locale_ = "";
    lex_.clear();

    // TODO read file and load lexicon
}

// getters


std::deque<LexEntry> Lexicon::find( const std::string key ) {
    std::map <std::string, std::deque<LexEntry>, lexcomp >::iterator it;
    std::deque<LexEntry> empty;

    it = lex_.find( key );
    if ( it != lex_.end() )
        return (*it).second;
    else
        return empty;
}


bool Lexicon::isInAttached( const std::string word ) const {

    for (auto it = attached_.begin(); it != attached_.end(); it++)
        if ( *it == word ) return true;

    return false;
}


// operators

std::ostream &operator<<(std::ostream &ss, const Lexicon &lex) {
    ss << "Lexicon:" << "\t"
       << lex.name_ << "\t"
       << lex.langAsString() << "\t"
       << lex.locale_ << "\t"
       << lex.lex_.size() << "\n";

    // each lexicon entry is a deque of LexEntry objects
    for (auto it = lex.lex_.begin(); it != lex.lex_.end(); it++) {
        const std::deque<LexEntry> deq = (*it).second;
        for (auto it2 = deq.begin(); it2 != deq.end(); it2++)
            ss << *it2 << "\n";
    }

    ss << "Lexicon.attached:";

    for (auto it = lex.attached_.begin(); it != lex.attached_.end(); it++)
        ss << "\t" << *it;

    ss << "\n";

    return ss;
}


// mutators

void Lexicon::langAsString( std::string lang ) {
    lang_ = InClass::asLang( lang );
}


void Lexicon::insert( const LexEntry &le ) {

    // get the map key we want to find
    std::string key = le.word();

    // fetch the entry from the lexicon
    // we get an empty container if it is not found
    std::deque<LexEntry> entries = Lexicon::find( key );

    // see if it is already here and do nothing if it is
    for( auto entry = entries.begin(); entry != entries.end(); entry++ ) {
        if ( *entry == le )
            return;
    }

    // append the lexentry to the existing entries for this key
    entries.push_back( le );

    // save it back in the lexicon
    lex_[key] = entries;
}


void Lexicon::remove( const LexEntry &le ) {
    
    // get the map key we want to find
    std::string key = le.word();

    // fetch the entry from the lexicon
    // we get an empty container if it is not found
    std::deque<LexEntry> entries = find( key );

    // see if it is already here and do nothing if it is
    for( auto entry = entries.begin(); entry != entries.end(); entry++ ) {
        if ( *entry == le ) {
            entries.erase( entry );
            if ( le.isAttached() and not isInAttached( le.word() ) ) {
                attached_.push_back( le.word() );
            }

            if ( entries.size() == 0 ) {
                // remove the key from the lexicon
                auto it = lex_.find( key );
                if ( it != lex_.end() )
                    lex_.erase( it );
            }
            else {
                // save it back in the lexicon
                lex_[key] = entries;
            }
        }
    }       
}


