-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION address_standardizer2" to load this file. \quit

---------------------------------------------------------------------
-- Address Standardizer 2.0
-- Author: Stephen Woodbridge <woodbri@imaptools.com>
---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION as_standardize(
        address text,
        grammar text,
        lexicon text,
        locale text,
        filter text,
        OUT building text,
        OUT house_num text,
        OUT predir text,
        OUT qual text,
        OUT pretype text,
        OUT name text,
        OUT suftype text,
        OUT sufdir text,
        OUT ruralroute text,
        OUT extra text,
        OUT city text,
        OUT prov text,
        OUT country text,
        OUT postcode text,
        OUT box text,
        OUT unit text
        )
    RETURNS RECORD
    AS '$libdir/address_standardizer2-2.0', 'as_standardize'
    LANGUAGE 'c' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION as_parse(
        address text,
        lexicon text,
        locale text,
        filter text,
        OUT id bigint,
        OUT seq integer,
        OUT word text,
        OUT stdword text,
        OUT inclass text,
        OUT outclass text,
        OUT attached text
        )
    RETURNS SETOF RECORD
    AS '$libdir/address_standardizer2-2.0', 'as_parse'
    LANGUAGE 'c' IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION as_match(
        tokens text,
        grammar text,
        node text default 'ADDRESS',
        OUT id bigint,
        OUT seq integer,
        OUT word text,
        OUT stdword text,
        OUT inclass text,
        OUT outclass text,
        OUT attached text
        )
    RETURNS SETOF RECORD
    AS '$libdir/address_standardizer2-2.0', 'as_parse'
    LANGUAGE 'c' IMMUTABLE STRICT;


