﻿
drop table if exists test_data cascade;
create table test_data (
    id serial not null primary key,
    name text unique,
    grammar text,
    lexicon text
);

insert into test_data values (1, 'test-1','
[HOUSE_NUMBER]
NUMBER -> HOUSE -> 0.3
FRACT  -> HOUSE -> 0.2
MIXED  -> HOUSE -> 0.1
NUMBER SINGLE -> HOUSE HOUSE -> 0.1
NUMBER DOUBLE -> HOUSE HOUSE -> 0.1
NUMBER MIXED  -> HOUSE HOUSE -> 0.1
NUMBER WORD   -> HOUSE HOUSE -> 0.1

[SECOND_UNIT]
NUMBER -> UNITT -> 0.1
MIXED  -> UNITT -> 0.1
UNITH NUMBER -> UNITH UNITT -> 0.3
UNITH MIXED  -> UNITH UNITT -> 0.3
UNITH SINGLE -> UNITH UNITT -> 0.3
UNITH DOUBLE -> UNITH UNITT -> 0.3
UNITH WORD   -> UNITH UNITT -> 0.2

[PLACENAME]
WORD PLACEN -> BLDNG BLDNG -> 0.1
PLACEN WORD -> BLDNG BLDNG -> 0.1
PLACEN      -> BLDNG       -> 0.1

[STREET_NAME]
TYPE WORD DIRECT  -> PRETYP STREET SUFDIR -> 0.3
WORD TYPE DIRECT  -> STREET SUFTYP SUFDIR -> 0.3
TYPE WORD   -> PRETYP STREET -> 0.3
WORD TYPE   -> STREET SUFTYP -> 0.3


[MACRO]
# German
SINGLE NUMBER CITY PROV NATION     -> EXTRA POSTAL CITY PROV NATION -> 0.5
SINGLE NUMBER WORD PROV NATION     -> EXTRA POSTAL CITY PROV NATION -> 0.3
SINGLE NUMBER CITY NATION          -> EXTRA POSTAL CITY NATION -> 0.5
SINGLE NUMBER PROV NATION          -> EXTRA POSTAL CITY NATION -> 0.5
SINGLE NUMBER WORD NATION          -> EXTRA POSTAL CITY NATION -> 0.3
NUMBER CITY PROV NATION     -> POSTAL CITY PROV NATION -> 0.5
NUMBER WORD PROV NATION     -> POSTAL CITY PROV NATION -> 0.3
NUMBER CITY NATION          -> POSTAL CITY NATION -> 0.5
NUMBER PROV NATION          -> POSTAL CITY NATION -> 0.5
NUMBER WORD NATION          -> POSTAL CITY NATION -> 0.3
# US
CITY PROV NUMBER NATION     -> CITY PROV POSTAL NATION -> 0.5
CITY PROV QUINT NATION      -> CITY PROV POSTAL NATION -> 0.5
CITY PROV QUINT QUAD NATION -> CITY PROV POSTAL POSTAL NATION -> 0.6
WORD PROV QUINT NATION      -> CITY PROV POSTAL NATION -> 0.4
WORD PROV QUINT QUAD NATION -> CITY PROV POSTAL POSTAL NATION -> 0.5
WORD PROV NUMBER NATION     -> CITY PROV POSTAL NATION -> 0.3
DIRECT WORD PROV QUINT NATION      -> CITY CITY PROV POSTAL NATION -> 0.4
DIRECT WORD PROV QUINT QUAD NATION -> CITY CITY PROV POSTAL POSTAL NATION -> 0.5
DIRECT WORD PROV NUMBER NATION     -> CITY CITY PROV POSTAL NATION -> 0.3
DIRECT WORD PROV NATION     -> CITY CITY PROV NATION -> 0.3
DIRECT WORD WORD PROV NATION     -> CITY CITY CITY PROV NATION -> 0.3
# Canada, UK
CITY PROV MIXED NATION      -> CITY PROV POSTAL NATION -> 0.5
CITY PROV PCH PCT NATION    -> CITY PROV POSTAL POSTAL NATION -> 0.5
WORD PROV PCH PCT NATION    -> CITY PROV POSTAL POSTAL NATION -> 0.4

[STREET_ADDRESS]
@HOUSE_NUMBER @STREET_NAME
@HOUSE_NUMBER @STREET_NAME @SECOND_UNIT
@STREET_NAME @HOUSE_NUMBER
@STREET_NAME @HOUSE_NUMBER @SECOND_UNIT

[ADDRESS]
@STREET_ADDRESS @MACRO
@PLACENAME @STREET_ADDRESS @MACRO

[ADDRESS2]
@STREET_ADDRESS @MACRO
@PLACENAME @STREET_ADDRESS @MACRO
',

'
LEXICON:	lex-usa.txt	ENG	en_US	
LEXENTRY:	#	APT	UNITH	DETACH
LEXENTRY:	1	1	NUMBER	DETACH
LEXENTRY:	10	10	NUMBER	DETACH
LEXENTRY:	10TH	10TH	WORD,ORD	DETACH
LEXENTRY:	11	11	NUMBER	DETACH
LEXENTRY:	11TH	11TH	WORD,ORD	DETACH
LEXENTRY:	12	12	NUMBER	DETACH
LEXENTRY:	12TH	12TH	WORD,ORD	DETACH
LEXENTRY:	13	13	NUMBER	DETACH
LEXENTRY:	13TH	13TH	WORD,ORD	DETACH
LEXENTRY:	14	14	NUMBER	DETACH
LEXENTRY:	14TH	14TH	WORD,ORD	DETACH
LEXENTRY:	15	15	NUMBER	DETACH
LEXENTRY:	15TH	15TH	WORD,ORD	DETACH
LEXENTRY:	16	16	NUMBER	DETACH
LEXENTRY:	16TH	16TH	WORD,ORD	DETACH
LEXENTRY:	17	17	NUMBER	DETACH
LEXENTRY:	17TH	17TH	WORD,ORD	DETACH
LEXENTRY:	18	18	NUMBER	DETACH
LEXENTRY:	18TH	18TH	WORD,ORD	DETACH
LEXENTRY:	19	19	NUMBER	DETACH
LEXENTRY:	19TH	19TH	WORD,ORD	DETACH
LEXENTRY:	1ST	1ST	WORD,ORD	DETACH
LEXENTRY:	2	2	NUMBER	DETACH
LEXENTRY:	20	20	NUMBER	DETACH
LEXENTRY:	20TH	20TH	WORD,ORD	DETACH
LEXENTRY:	2ND	2ND	WORD,ORD	DETACH
LEXENTRY:	3	3	NUMBER	DETACH
LEXENTRY:	30	30	NUMBER	DETACH
LEXENTRY:	30TH	30TH	WORD,ORD	DETACH
LEXENTRY:	3RD	3RD	WORD,ORD	DETACH
LEXENTRY:	4	4	NUMBER	DETACH
LEXENTRY:	40	40	NUMBER	DETACH
LEXENTRY:	40TH	40TH	WORD,ORD	DETACH
LEXENTRY:	4TH	4TH	WORD,ORD	DETACH
LEXENTRY:	5	5	NUMBER	DETACH
LEXENTRY:	50	50	NUMBER	DETACH
LEXENTRY:	50TH	50TH	WORD,ORD	DETACH
LEXENTRY:	5TH	5TH	WORD,ORD	DETACH
LEXENTRY:	6	6	NUMBER	DETACH
LEXENTRY:	60	60	NUMBER	DETACH
LEXENTRY:	60TH	60TH	WORD,ORD	DETACH
LEXENTRY:	6TH	6TH	WORD,ORD	DETACH
LEXENTRY:	7	7	NUMBER	DETACH
LEXENTRY:	70	70	NUMBER	DETACH
LEXENTRY:	70TH	70TH	WORD,ORD	DETACH
LEXENTRY:	7TH	7TH	WORD,ORD	DETACH
LEXENTRY:	8	8	NUMBER	DETACH
LEXENTRY:	80	80	NUMBER	DETACH
LEXENTRY:	80TH	80TH	WORD,ORD	DETACH
LEXENTRY:	8TH	8TH	WORD,ORD	DETACH
LEXENTRY:	9	9	NUMBER	DETACH
LEXENTRY:	90	90	NUMBER	DETACH
LEXENTRY:	90TH	90TH	WORD,ORD	DETACH
LEXENTRY:	9TH	9TH	WORD,ORD	DETACH
LEXENTRY:	AK	Alaska	PROV	DETACH
LEXENTRY:	AL	Alabama	PROV	DETACH
LEXENTRY:	ALLEE	ALY	TYPE	DET_SUF
LEXENTRY:	ALLEY	ALY	TYPE	DET_SUF
LEXENTRY:	ALLY	ALY	TYPE	DET_SUF
LEXENTRY:	ALY	ALY	TYPE	DET_SUF
LEXENTRY:	ANEX	ANX	TYPE	DET_SUF
LEXENTRY:	ANNEX	ANX	TYPE	DET_SUF
LEXENTRY:	ANNX	ANX	TYPE	DET_SUF
LEXENTRY:	ANX	ANX	TYPE	DET_SUF
LEXENTRY:	APARTMENT	APT	UNITH	DETACH
LEXENTRY:	APT	APT	UNITH	DETACH
LEXENTRY:	APT.	APT	UNITH	DETACH
LEXENTRY:	AR	Arkansas	PROV	DETACH
LEXENTRY:	ARC	ARC	TYPE	DET_SUF
LEXENTRY:	ARCADE	ARC	TYPE	DET_SUF
LEXENTRY:	ASSOCIATION	ASSOCIATION	PLACEN	DETACH
LEXENTRY:	AUTO	AUTO	PLACEN	DETACH
LEXENTRY:	AV	AVE	TYPE	DET_PRE,DET_SUF
LEXENTRY:	AV OF	AVENUE OF	WORD	DETACH
LEXENTRY:	AV.	AVE	TYPE	DET_PRE,DET_SUF
LEXENTRY:	AV. OF	AVENUE OF	WORD	DETACH
LEXENTRY:	AVE	AVE	TYPE	DET_PRE,DET_SUF
LEXENTRY:	AVE.	AVE	TYPE	DET_PRE,DET_SUF
LEXENTRY:	AVE. OF	AVENUE OF	WORD	DETACH
LEXENTRY:	AVEN	AVE	TYPE	DET_PRE,DET_SUF
LEXENTRY:	AVENU	AVE	TYPE	DET_PRE,DET_SUF
LEXENTRY:	AVENUE	AVE	TYPE	DET_PRE,DET_SUF
LEXENTRY:	AVENIDA	AVENIDA	TYPE	DETACH
LEXENTRY:	AVENUE OF	AVENUE OF	WORD	DETACH
LEXENTRY:	AVN	AVE	TYPE	DET_PRE,DET_SUF
LEXENTRY:	AVNUE	AVE	TYPE	DET_PRE,DET_SUF
LEXENTRY:	AZ	Arizona	PROV	DETACH
LEXENTRY:	BANK	BANK	PLACEN	DETACH
LEXENTRY:	BASEMENT	BASEMENT	UNITH	DETACH
LEXENTRY:	BAYOO	BYU	TYPE	DET_SUF
LEXENTRY:	BAYOU	BYU	TYPE	DET_SUF
LEXENTRY:	BCH	BCH	TYPE	DET_SUF
LEXENTRY:	BEACH	BCH	TYPE	DET_SUF
LEXENTRY:	BEND	BND	TYPE	DET_SUF
LEXENTRY:	BG	BG	TYPE	DET_SUF
LEXENTRY:	BGS	BGS	TYPE	DET_SUF
LEXENTRY:	BLDG	BUILDING	UNITH	DETACH
LEXENTRY:	BLDG.	BUILDING	UNITH	DETACH
LEXENTRY:	BLF	BLF	TYPE	DET_SUF
LEXENTRY:	BLFS	BLFS	TYPE	DET_SUF
LEXENTRY:	BLUF	BLF	TYPE	DET_SUF
LEXENTRY:	BLUFF	BLF	TYPE	DET_SUF
LEXENTRY:	BLUFFS	BLFS	TYPE	DET_SUF
LEXENTRY:	BLVD	BLVD	TYPE	DET_SUF
LEXENTRY:	BLVD OF	BOULEVARD OF	WORD	DETACH
LEXENTRY:	BLVD.	BLVD	TYPE	DET_SUF
LEXENTRY:	BLVD. OF	BOULEVARD OF	WORD	DETACH
LEXENTRY:	BND	BND	TYPE	DET_SUF
LEXENTRY:	BOT	BTM	TYPE	DET_SUF
LEXENTRY:	BOTTM	BTM	TYPE	DET_SUF
LEXENTRY:	BOTTOM	BTM	TYPE	DET_SUF
LEXENTRY:	BOUL	BLVD	TYPE	DET_SUF
LEXENTRY:	BOULEVARD	BLVD	TYPE	DET_SUF
LEXENTRY:	BOULEVARD OF	BOULEVARD OF	WORD	DETACH
LEXENTRY:	BOULV	BLVD	TYPE	DET_SUF
LEXENTRY:	BR	BR	TYPE	DET_SUF
LEXENTRY:	BR.	BR	TYPE	DET_SUF
LEXENTRY:	BRANCH	BR	TYPE	DET_SUF
LEXENTRY:	BRDGE	BRG	TYPE	DET_SUF
LEXENTRY:	BRG	BRG	TYPE	DET_SUF
LEXENTRY:	BRIDGE	BRIDGE	PLACEN	DETACH
LEXENTRY:	BRIDGE	BRG	TYPE	DET_SUF
LEXENTRY:	BRK	BRK	TYPE	DET_SUF
LEXENTRY:	BRKS	BRKS	TYPE	DET_SUF
LEXENTRY:	BRNCH	BR	TYPE	DET_SUF
LEXENTRY:	BROOK	BRK	TYPE	DET_SUF
LEXENTRY:	BROOKS	BRKS	TYPE	DET_SUF
LEXENTRY:	BSMT	BASEMENT	UNITH	DETACH
LEXENTRY:	BSMT.	BASEMENT	UNITH	DETACH
LEXENTRY:	BTM	BTM	TYPE	DET_SUF
LEXENTRY:	BUILDING	BUILDING	PLACEN,UNITH	DETACH
LEXENTRY:	BUREAU	BUREAU	PLACEN	DETACH
LEXENTRY:	BURG	BG	TYPE	DET_SUF
LEXENTRY:	BURGS	BGS	TYPE	DET_SUF
LEXENTRY:	BUSINESS	BUSINESS	QUALIF	DETACH
LEXENTRY:	BUS	BUSINESS	QUALIF	DETACH
LEXENTRY:	BYP	BYP	TYPE	DET_SUF
LEXENTRY:	BYPA	BYP	TYPE	DET_SUF
LEXENTRY:	BYPAS	BYP	TYPE	DET_SUF
LEXENTRY:	BYPASS	BYP	TYPE	DET_SUF
LEXENTRY:	BYPS	BYP	TYPE	DET_SUF
LEXENTRY:	BYU	BYU	TYPE	DET_SUF
LEXENTRY:	CA	CALIFORNIA	PROV	DETACH
LEXENTRY:	CALIFORNIA	CALIFORNIA	PROV	DETACH
LEXENTRY:	CAFE	CAFE	PLACEN	DETACH
LEXENTRY:	CALLE	CALLE	TYPE	DETACH
LEXENTRY:	CAMP	CMP	TYPE	DET_SUF
LEXENTRY:	CANYN	CYN	TYPE	DET_SUF
LEXENTRY:	CANYON	CYN	TYPE	DET_SUF
LEXENTRY:	CAPE	CPE	TYPE	DET_SUF
LEXENTRY:	CATHEDRAL	CATHEDRAL	PLACEN	DETACH
LEXENTRY:	CAUSEWAY	CSWY	TYPE	DET_SUF
LEXENTRY:	CAUSWAY	CSWY	TYPE	DET_SUF
LEXENTRY:	CEN	CTR	TYPE	DET_SUF
LEXENTRY:	CENT	CTR	TYPE	DET_SUF
LEXENTRY:	CENTER	CENTER	PLACEN	DETACH
LEXENTRY:	CENTER	CTR	TYPE	DET_SUF
LEXENTRY:	CENTERS	CTRS	TYPE	DET_SUF
LEXENTRY:	CENTR	CTR	TYPE	DET_SUF
LEXENTRY:	CENTRE	CTR	TYPE	DET_SUF
LEXENTRY:	CHELMSFORD	CHELMSFORD	CITY,WORD	DETACH
LEXENTRY:	CHURCH	CHURCH	PLACEN	DETACH
LEXENTRY:	CIR	CIR	TYPE	DET_SUF
LEXENTRY:	CIRC	CIR	TYPE	DET_SUF
LEXENTRY:	CIRCL	CIR	TYPE	DET_SUF
LEXENTRY:	CIRCLE	CIR	TYPE	DET_SUF
LEXENTRY:	CIRCLES	CIRS	TYPE	DET_SUF
LEXENTRY:	CIRS	CIRS	TYPE	DET_SUF
LEXENTRY:	CK	CRK	TYPE	DET_SUF
LEXENTRY:	CLB	CLB	TYPE	DET_SUF
LEXENTRY:	CLF	CLF	TYPE	DET_SUF
LEXENTRY:	CLFS	CLFS	TYPE	DET_SUF
LEXENTRY:	CLIFF	CLF	TYPE	DET_SUF
LEXENTRY:	CLIFFS	CLFS	TYPE	DET_SUF
LEXENTRY:	CLUB	CLUB	PLACEN	DETACH
LEXENTRY:	CLUB	CLB	TYPE	DET_SUF
LEXENTRY:	CMN	CMN	TYPE	DET_SUF
LEXENTRY:	CMP	CMP	TYPE	DET_SUF
LEXENTRY:	CNTER	CTR	TYPE	DET_SUF
LEXENTRY:	CNTR	CTR	TYPE	DET_SUF
LEXENTRY:	CNYN	CYN	TYPE	DET_SUF
LEXENTRY:	CO	Colorado	PROV	DETACH
LEXENTRY:	CO	CO	PLACEN	DETACH
LEXENTRY:	COLLEGE	COLLEGE	PLACEN	DETACH
LEXENTRY:	COMMON	CMN	TYPE	DET_SUF
LEXENTRY:	COMPANY	COMPANY	PLACEN	DETACH
LEXENTRY:	COR	COR	TYPE	DET_SUF
LEXENTRY:	CORNER	COR	TYPE	DET_SUF
LEXENTRY:	CORNERS	CORS	TYPE	DET_SUF
LEXENTRY:	CORP	CORP	PLACEN	DETACH
LEXENTRY:	CORPORATION	CORPORATION	PLACEN	DETACH
LEXENTRY:	CORS	CORS	TYPE	DET_SUF
LEXENTRY:	COUNTY ROAD	COUNTY ROAD	ROAD	DET_PRE
LEXENTRY:	COUNTY RD	COUNTY ROAD	ROAD	DET_PRE
LEXENTRY:	CO RD	COUNTY ROAD	ROAD	DET_PRE
LEXENTRY:	COURSE	COURSE	PLACEN	DETACH
LEXENTRY:	COURSE	CRSE	TYPE	DET_SUF
LEXENTRY:	COURT	COURT	PLACEN	DETACH
LEXENTRY:	COURT	CT	TYPE	DET_SUF
LEXENTRY:	COURTS	CTS	TYPE	DET_SUF
LEXENTRY:	COVE	CV	TYPE	DET_SUF
LEXENTRY:	COVES	CVS	TYPE	DET_SUF
LEXENTRY:	CP	CMP	TYPE	DET_SUF
LEXENTRY:	CPE	CPE	TYPE	DET_SUF
LEXENTRY:	CR	CRK	TYPE	DET_SUF
LEXENTRY:	CRCL	CIR	TYPE	DET_SUF
LEXENTRY:	CRCLE	CIR	TYPE	DET_SUF
LEXENTRY:	CREDIT	CREDIT	PLACEN	DETACH
LEXENTRY:	CREEK	CRK	TYPE	DET_SUF
LEXENTRY:	CRES	CRES	TYPE	DET_SUF
LEXENTRY:	CRESCENT	CRES	TYPE	DET_SUF
LEXENTRY:	CRESENT	CRES	TYPE	DET_SUF
LEXENTRY:	CREST	CRES	TYPE	DET_SUF
LEXENTRY:	CRK	CRK	TYPE	DET_SUF
LEXENTRY:	CROSSING	XING	TYPE	DET_SUF
LEXENTRY:	CROSSROAD	XRD	TYPE	DET_SUF
LEXENTRY:	CRSCNT	CRES	TYPE	DET_SUF
LEXENTRY:	CRSE	CRSE	TYPE	DET_SUF
LEXENTRY:	CRSENT	CRES	TYPE	DET_SUF
LEXENTRY:	CRSNT	CRES	TYPE	DET_SUF
LEXENTRY:	CRSSING	XING	TYPE	DET_SUF
LEXENTRY:	CRSSNG	XING	TYPE	DET_SUF
LEXENTRY:	CRT	CT	TYPE	DET_SUF
LEXENTRY:	CSWY	CSWY	TYPE	DET_SUF
LEXENTRY:	CT	Connecticut	PROV	DETACH
LEXENTRY:	CT	CT	TYPE	DET_SUF
LEXENTRY:	CTR	CTR	TYPE	DET_SUF
LEXENTRY:	CTRS	CTRS	TYPE	DET_SUF
LEXENTRY:	CTS	CTS	TYPE	DET_SUF
LEXENTRY:	CU	CU	PLACEN	DETACH
LEXENTRY:	CURV	CURV	TYPE	DET_SUF
LEXENTRY:	CURVE	CURV	TYPE	DET_SUF
LEXENTRY:	CV	CV	TYPE	DET_SUF
LEXENTRY:	CVS	CVS	TYPE	DET_SUF
LEXENTRY:	CYN	CYN	TYPE	DET_SUF
LEXENTRY:	D/B/A	D/B/A	PLACEN	DETACH
LEXENTRY:	DALE	DL	TYPE	DET_SUF
LEXENTRY:	DAM	DM	TYPE	DET_SUF
LEXENTRY:	DC	District of Columbia	PROV	DETACH
LEXENTRY:	DE	Delaware	PROV	DETACH
LEXENTRY:	DELI	DELI	PLACEN	DETACH
LEXENTRY:	DEPARTMENT	DEPARTMENT	PLACEN,UNITH	DETACH
LEXENTRY:	DEPT	DEPARTMENT	UNITH	DETACH
LEXENTRY:	DEPT.	DEPARTMENT	UNITH	DETACH
LEXENTRY:	DISTRICT	DISTRICT	PLACEN	DETACH
LEXENTRY:	DIV	DV	TYPE	DET_SUF
LEXENTRY:	DIVIDE	DV	TYPE	DET_SUF
LEXENTRY:	DL	DL	TYPE	DET_SUF
LEXENTRY:	DM	DM	TYPE	DET_SUF
LEXENTRY:	DR	DR	TYPE	DET_SUF
LEXENTRY:	DR.	DR	TYPE	DET_SUF
LEXENTRY:	DRIV	DR	TYPE	DET_SUF
LEXENTRY:	DRIVE	DR	TYPE	DET_SUF
LEXENTRY:	DRIVES	DRS	TYPE	DET_SUF
LEXENTRY:	DRS	DRS	TYPE	DET_SUF
LEXENTRY:	DRV	DR	TYPE	DET_SUF
LEXENTRY:	DRV.	DR	TYPE	DET_SUF
LEXENTRY:	DV	DV	TYPE	DET_SUF
LEXENTRY:	DVD	DV	TYPE	DET_SUF
LEXENTRY:	E	EAST	DIRECT,WORD	DETACH
LEXENTRY:	E.	EAST	DIRECT,WORD	DETACH
LEXENTRY:	EAST	EAST	DIRECT,WORD	DETACH
LEXENTRY:	EIGHT	8	NUMBER	DETACH
LEXENTRY:	EIGHTEEN	18	NUMBER	DETACH
LEXENTRY:	EIGHTEENTH	18TH	WORD,ORD	DETACH
LEXENTRY:	EIGHTH	8TH	WORD,ORD	DETACH
LEXENTRY:	EIGHTIETH	80TH	WORD,ORD	DETACH
LEXENTRY:	EIGHTY	80	NUMBER	DETACH
LEXENTRY:	ELEVEN	11	NUMBER	DETACH
LEXENTRY:	ELEVENTH	11TH	WORD,ORD	DETACH
LEXENTRY:	EMBASSY	EMBASSY	PLACEN	DETACH
LEXENTRY:	EST	EST	TYPE	DET_SUF
LEXENTRY:	ESTATE	EST	TYPE	DET_SUF
LEXENTRY:	ESTATES	ESTS	TYPE	DET_SUF
LEXENTRY:	ESTS	ESTS	TYPE	DET_SUF
LEXENTRY:	EXPR	EXPY	TYPE	DET_SUF
LEXENTRY:	EXPRESS	EXPY	TYPE	DET_SUF
LEXENTRY:	EXPRESSWAY	EXPY	TYPE	DET_SUF
LEXENTRY:	EXPW	EXPY	TYPE	DET_SUF
LEXENTRY:	EXPY	EXPY	TYPE	DET_SUF
LEXENTRY:	EXT	EXT	TYPE	DET_SUF
LEXENTRY:	EXTENSION	EXT	TYPE	DET_SUF
LEXENTRY:	EXTENSIONS	EXTS	TYPE	DET_SUF
LEXENTRY:	EXTN	EXT	TYPE	DET_SUF
LEXENTRY:	EXTNSN	EXT	TYPE	DET_SUF
LEXENTRY:	EXTS	EXTS	TYPE	DET_SUF
LEXENTRY:	FALL	FALL	TYPE	DET_SUF
LEXENTRY:	FALLS	FLS	TYPE	DET_SUF
LEXENTRY:	FCU	FCU	PLACEN	DETACH
LEXENTRY:	FERRY	FRY	TYPE	DET_SUF
LEXENTRY:	FIELD	FLD	TYPE	DET_SUF
LEXENTRY:	FIELDS	FLDS	TYPE	DET_SUF
LEXENTRY:	FIFTEEN	15	NUMBER	DETACH
LEXENTRY:	FIFTEENTH	15TH	WORD,ORD	DETACH
LEXENTRY:	FIFTH	5TH	WORD,ORD	DETACH
LEXENTRY:	FIFTIETH	50TH	WORD,ORD	DETACH
LEXENTRY:	FIFTY	50	NUMBER	DETACH
LEXENTRY:	FIRST	1ST	WORD,ORD	DETACH
LEXENTRY:	FIVE	5	NUMBER	DETACH
LEXENTRY:	FL	FLOOR	UNITH	DETACH
LEXENTRY:	FL	Florida	PROV	DETACH
LEXENTRY:	FL.	FLOOR	UNITH	DETACH
LEXENTRY:	FLAT	FLT	TYPE	DET_SUF
LEXENTRY:	FLATS	FLTS	TYPE	DET_SUF
LEXENTRY:	FLD	FLD	TYPE	DET_SUF
LEXENTRY:	FLDS	FLDS	TYPE	DET_SUF
LEXENTRY:	FLOOR	FLOOR	UNITH	DETACH
LEXENTRY:	FLS	FLS	TYPE	DET_SUF
LEXENTRY:	FLT	FLT	TYPE	DET_SUF
LEXENTRY:	FLTS	FLTS	TYPE	DET_SUF
LEXENTRY:	FORD	FRD	TYPE	DET_SUF
LEXENTRY:	FORDS	FRDS	TYPE	DET_SUF
LEXENTRY:	FOREST	FRST	TYPE	DET_SUF
LEXENTRY:	FORESTS	FRST	TYPE	DET_SUF
LEXENTRY:	FORG	FRG	TYPE	DET_SUF
LEXENTRY:	FORGE	FRG	TYPE	DET_SUF
LEXENTRY:	FORGES	FRGS	TYPE	DET_SUF
LEXENTRY:	FORK	FRK	TYPE	DET_SUF
LEXENTRY:	FORKS	FRKS	TYPE	DET_SUF
LEXENTRY:	FORT	FT	TYPE	DET_SUF
LEXENTRY:	FORTIETH	40TH	WORD,ORD	DETACH
LEXENTRY:	FORTY	40	NUMBER	DETACH
LEXENTRY:	FOUR	4	NUMBER	DETACH
LEXENTRY:	FOURTEEN	14	NUMBER	DETACH
LEXENTRY:	FOURTEENTH	14TH	WORD,ORD	DETACH
LEXENTRY:	FOUTH	4TH	WORD,ORD	DETACH
LEXENTRY:	FRD	FRD	TYPE	DET_SUF
LEXENTRY:	FRDS	FRDS	TYPE	DET_SUF
LEXENTRY:	FREEWAY	FWY	TYPE	DET_SUF
LEXENTRY:	FREEWY	FWY	TYPE	DET_SUF
LEXENTRY:	FRG	FRG	TYPE	DET_SUF
LEXENTRY:	FRGS	FRGS	TYPE	DET_SUF
LEXENTRY:	FRK	FRK	TYPE	DET_SUF
LEXENTRY:	FRKS	FRKS	TYPE	DET_SUF
LEXENTRY:	FRNT	FRONT	UNITH	DETACH
LEXENTRY:	FRONT	FRONT	UNITH	DETACH
LEXENTRY:	FRRY	FRY	TYPE	DET_SUF
LEXENTRY:	FRST	FRST	TYPE	DET_SUF
LEXENTRY:	FRT	FT	TYPE	DET_SUF
LEXENTRY:	FRWAY	FWY	TYPE	DET_SUF
LEXENTRY:	FRWY	FWY	TYPE	DET_SUF
LEXENTRY:	FRY	FRY	TYPE	DET_SUF
LEXENTRY:	FT	FT	TYPE	DET_SUF
LEXENTRY:	FUND	FUND	PLACEN	DETACH
LEXENTRY:	FWY	FWY	TYPE	DET_SUF
LEXENTRY:	GA	Georgia	PROV	DETACH
LEXENTRY:	GALLERY	GALLERY	PLACEN	DETACH
LEXENTRY:	GARAGE	GARAGE	PLACEN	DETACH
LEXENTRY:	GARDEN	GDN	TYPE	DET_SUF
LEXENTRY:	GARDENS	GDNS	TYPE	DET_SUF
LEXENTRY:	GARDN	GDN	TYPE	DET_SUF
LEXENTRY:	GATEWAY	GTWY	TYPE	DET_SUF
LEXENTRY:	GATEWY	GTWY	TYPE	DET_SUF
LEXENTRY:	GATWAY	GTWY	TYPE	DET_SUF
LEXENTRY:	GDN	GDN	TYPE	DET_SUF
LEXENTRY:	GDNS	GDNS	TYPE	DET_SUF
LEXENTRY:	GLEN	GLN	TYPE	DET_SUF
LEXENTRY:	GLENS	GLNS	TYPE	DET_SUF
LEXENTRY:	GLN	GLN	TYPE	DET_SUF
LEXENTRY:	GLNS	GLNS	TYPE	DET_SUF
LEXENTRY:	GRDEN	GDN	TYPE	DET_SUF
LEXENTRY:	GRDN	GDN	TYPE	DET_SUF
LEXENTRY:	GRDNS	GDNS	TYPE	DET_SUF
LEXENTRY:	GREEN	GRN	TYPE	DET_SUF
LEXENTRY:	GREENS	GRNS	TYPE	DET_SUF
LEXENTRY:	GRILL	GRILL	PLACEN	DETACH
LEXENTRY:	GRN	GRN	TYPE	DET_SUF
LEXENTRY:	GRNS	GRNS	TYPE	DET_SUF
LEXENTRY:	GROUP	GROUP	PLACEN	DETACH
LEXENTRY:	GROV	GRV	TYPE	DET_SUF
LEXENTRY:	GROVE	GRV	TYPE	DET_SUF
LEXENTRY:	GROVES	GRVS	TYPE	DET_SUF
LEXENTRY:	GRV	GRV	TYPE	DET_SUF
LEXENTRY:	GRVS	GRVS	TYPE	DET_SUF
LEXENTRY:	GTWAY	GTWY	TYPE	DET_SUF
LEXENTRY:	GTWY	GTWY	TYPE	DET_SUF
LEXENTRY:	HALL	HALL	PLACEN	DETACH
LEXENTRY:	HANGAR	HANGAR	UNITH	DETACH
LEXENTRY:	HARB	HBR	TYPE	DET_SUF
LEXENTRY:	HARBOR	HBR	TYPE	DET_SUF
LEXENTRY:	HARBORS	HBRS	TYPE	DET_SUF
LEXENTRY:	HARBOUR	HARBOUR	PLACEN	DETACH
LEXENTRY:	HARBR	HBR	TYPE	DET_SUF
LEXENTRY:	HAVEN	HVN	TYPE	DET_SUF
LEXENTRY:	HAVN	HVN	TYPE	DET_SUF
LEXENTRY:	HBR	HBR	TYPE	DET_SUF
LEXENTRY:	HBRS	HBRS	TYPE	DET_SUF
LEXENTRY:	HEIGHT	HTS	TYPE	DET_SUF
LEXENTRY:	HEIGHTS	HTS	TYPE	DET_SUF
LEXENTRY:	HGTS	HTS	TYPE	DET_SUF
LEXENTRY:	HI	Hawaii	PROV	DETACH
LEXENTRY:	HIGHWAY	HWY	TYPE	DETACH
LEXENTRY:	HIGHWY	HWY	TYPE	DETACH
LEXENTRY:	HILL	HL	TYPE	DETACH
LEXENTRY:	HILLS	HLS	TYPE	DETACH
LEXENTRY:	HIWAY	HWY	TYPE	DETACH
LEXENTRY:	HIWY	HWY	TYPE	DETACH
LEXENTRY:	HL	HL	TYPE	DET_SUF
LEXENTRY:	HL.	HL	TYPE	DET_SUF
LEXENTRY:	HLLW	HOLW	TYPE	DET_SUF
LEXENTRY:	HLS	HLS	TYPE	DET_SUF
LEXENTRY:	HNGR	HANGAR	UNITH	DETACH
LEXENTRY:	HOLLOW	HOLW	TYPE	DET_SUF
LEXENTRY:	HOLLOWS	HOLW	TYPE	DET_SUF
LEXENTRY:	HOLW	HOLW	TYPE	DET_SUF
LEXENTRY:	HOLWS	HOLW	TYPE	DET_SUF
LEXENTRY:	HOTEL	HOTEL	PLACEN	DETACH
LEXENTRY:	HOUSE	HOUSE	PLACEN	DETACH
LEXENTRY:	HRBOR	HBR	TYPE	DET_SUF
LEXENTRY:	HT	HTS	TYPE	DET_SUF
LEXENTRY:	HTS	HTS	TYPE	DET_SUF
LEXENTRY:	HVN	HVN	TYPE	DET_SUF
LEXENTRY:	HWAY	HWY	TYPE	DETACH
LEXENTRY:	HWY	HWY	TYPE	DETACH
LEXENTRY:	HWY I	HWY I	TYPE	DETACH
LEXENTRY:	I	I	TYPE,SINGLE	DETACH
LEXENTRY:	IA	Iowa	PROV	DETACH
LEXENTRY:	ID	Idaho	PROV	DETACH
LEXENTRY:	IL	Illinois	PROV	DETACH
LEXENTRY:	IN	Indiana	PROV	DETACH
LEXENTRY:	INC	INC	PLACEN	DETACH
LEXENTRY:	INCORPORATED	INCORPORATED	PLACEN	DETACH
LEXENTRY:	INLET	INLT	TYPE	DET_SUF
LEXENTRY:	INLT	INLT	TYPE	DET_SUF
LEXENTRY:	INN	INN	PLACEN	DETACH
LEXENTRY:	INSTITUTE	INSTITUTE	PLACEN	DETACH
LEXENTRY:	IS	IS	TYPE	DET_SUF
LEXENTRY:	ISLAND	IS	TYPE	DET_SUF
LEXENTRY:	ISLANDS	ISS	TYPE	DET_SUF
LEXENTRY:	ISLE	ISLE	TYPE	DET_SUF
LEXENTRY:	ISLES	ISLE	TYPE	DET_SUF
LEXENTRY:	ISLND	IS	TYPE	DET_SUF
LEXENTRY:	ISLNDS	ISS	TYPE	DET_SUF
LEXENTRY:	ISS	ISS	TYPE	DET_SUF
LEXENTRY:	JCT	JCT	TYPE	DET_SUF
LEXENTRY:	JCTION	JCT	TYPE	DET_SUF
LEXENTRY:	JCTN	JCT	TYPE	DET_SUF
LEXENTRY:	JCTNS	JCTS	TYPE	DET_SUF
LEXENTRY:	JCTS	JCTS	TYPE	DET_SUF
LEXENTRY:	JUNCTION	JCT	TYPE	DET_SUF
LEXENTRY:	JUNCTIONS	JCTS	TYPE	DET_SUF
LEXENTRY:	JUNCTN	JCT	TYPE	DET_SUF
LEXENTRY:	JUNCTON	JCT	TYPE	DET_SUF
LEXENTRY:	KEY	KY	TYPE	DET_SUF
LEXENTRY:	KEYS	KYS	TYPE	DET_SUF
LEXENTRY:	KNL	KNL	TYPE	DET_SUF
LEXENTRY:	KNLS	KNLS	TYPE	DET_SUF
LEXENTRY:	KNOL	KNL	TYPE	DET_SUF
LEXENTRY:	KNOLL	KNL	TYPE	DET_SUF
LEXENTRY:	KNOLLS	KNLS	TYPE	DET_SUF
LEXENTRY:	KS	Kansas	PROV	DETACH
LEXENTRY:	KY	Kentucky	PROV	DETACH
LEXENTRY:	KY	KY	TYPE	DET_SUF
LEXENTRY:	KYS	KYS	TYPE	DET_SUF
LEXENTRY:	LA	Louisiana	PROV	DETACH
LEXENTRY:	LA	LN	TYPE	DET_SUF
LEXENTRY:	LAB	LAB	PLACEN	DETACH
LEXENTRY:	LABORATORIES	LABORATORIES	PLACEN	DETACH
LEXENTRY:	LABORATORY	LABORATORY	PLACEN	DETACH
LEXENTRY:	LABS	LABS	PLACEN	DETACH
LEXENTRY:	LAKE	LK	TYPE	DET_SUF
LEXENTRY:	LAKES	LKS	TYPE	DET_SUF
LEXENTRY:	LAND	LAND	TYPE	DET_SUF
LEXENTRY:	LANDING	LNDG	TYPE	DET_SUF
LEXENTRY:	LANE	LN	TYPE	DET_SUF
LEXENTRY:	LANES	LN	TYPE	DET_SUF
LEXENTRY:	LBBY	LOBBY	UNITH	DETACH
LEXENTRY:	LCK	LCK	TYPE	DET_SUF
LEXENTRY:	LCKS	LCKS	TYPE	DET_SUF
LEXENTRY:	LDG	LDG	TYPE	DET_SUF
LEXENTRY:	LDGE	LDG	TYPE	DET_SUF
LEXENTRY:	LF	LF	TYPE	DET_SUF
LEXENTRY:	LGT	LGT	TYPE	DET_SUF
LEXENTRY:	LGTS	LGTS	TYPE	DET_SUF
LEXENTRY:	LIBRARY	LIBRARY	PLACEN	DETACH
LEXENTRY:	LIGHT	LGT	TYPE	DET_SUF
LEXENTRY:	LIGHTS	LGTS	TYPE	DET_SUF
LEXENTRY:	LIMITED	LIMITED	PLACEN	DETACH
LEXENTRY:	LK	LK	TYPE	DET_SUF
LEXENTRY:	LKS	LKS	TYPE	DET_SUF
LEXENTRY:	LLC	LLC	PLACEN	DETACH
LEXENTRY:	LLP	LLP	PLACEN	DETACH
LEXENTRY:	LN	LN	TYPE	DET_SUF
LEXENTRY:	LN.	LN	TYPE	DET_SUF
LEXENTRY:	LNDG	LNDG	TYPE	DET_SUF
LEXENTRY:	LNDNG	LNDG	TYPE	DET_SUF
LEXENTRY:	LOAF	LF	TYPE	DET_SUF
LEXENTRY:	LOBBY	LOBBY	UNITH	DETACH
LEXENTRY:	LOCK	LCK	TYPE	DET_SUF
LEXENTRY:	LOCKS	LCKS	TYPE	DET_SUF
LEXENTRY:	LODG	LDG	TYPE	DET_SUF
LEXENTRY:	LODGE	LDG	TYPE	DET_SUF
LEXENTRY:	LOOP	LOOP	TYPE	DET_SUF
LEXENTRY:	LOOPS	LOOP	TYPE	DET_SUF
LEXENTRY:	LOT	LOT	UNITH	DETACH
LEXENTRY:	LOWER	LOWER	UNITH	DETACH
LEXENTRY:	LOWR	LOWER	UNITH	DETACH
LEXENTRY:	LP	LP	PLACEN	DETACH
LEXENTRY:	LTD	LTD	PLACEN	DETACH
LEXENTRY:	MA	Massachusetts	PROV	DETACH
LEXENTRY:	MALL	MALL	TYPE	DET_SUF
LEXENTRY:	MANOR	MNR	TYPE	DET_SUF
LEXENTRY:	MANORS	MNRS	TYPE	DET_SUF
LEXENTRY:	MARKET	MARKET	PLACEN	DETACH
LEXENTRY:	MD	Maryland	PROV	DETACH
LEXENTRY:	MDW	MDW	TYPE	DET_SUF
LEXENTRY:	MDWS	MDWS	TYPE	DET_SUF
LEXENTRY:	ME	Maine	PROV	DETACH
LEXENTRY:	MEADOW	MDW	TYPE	DET_SUF
LEXENTRY:	MEADOWS	MDWS	TYPE	DET_SUF
LEXENTRY:	MEDOWS	MDWS	TYPE	DET_SUF
LEXENTRY:	MEMORIAL	MEMORIAL	PLACEN	DETACH
LEXENTRY:	MEWS	MEWS	TYPE	DET_SUF
LEXENTRY:	MI	Michigan	PROV	DETACH
LEXENTRY:	MILL	ML	TYPE	DET_SUF
LEXENTRY:	MILLS	MLS	TYPE	DET_SUF
LEXENTRY:	MISSION	MSN	TYPE	DET_SUF
LEXENTRY:	MISSN	MSN	TYPE	DET_SUF
LEXENTRY:	ML	ML	TYPE	DET_SUF
LEXENTRY:	MLS	MLS	TYPE	DET_SUF
LEXENTRY:	MN	Minnesota	PROV	DETACH
LEXENTRY:	MNR	MNR	TYPE	DET_SUF
LEXENTRY:	MNRS	MNRS	TYPE	DET_SUF
LEXENTRY:	MNT	MT	TYPE	DET_SUF
LEXENTRY:	MNTAIN	MTN	TYPE	DET_SUF
LEXENTRY:	MNTN	MTN	TYPE	DET_SUF
LEXENTRY:	MO	Missouri	PROV	DETACH
LEXENTRY:	MONUMENT	MONUMENT	PLACEN	DETACH
LEXENTRY:	MOTELL	MOTELL	PLACEN	DETACH
LEXENTRY:	MOTORWAY	MTWY	TYPE	DET_SUF
LEXENTRY:	MOUNT	MT	TYPE,WORD	DETACH,DET_SUF
LEXENTRY:	MOUNTAIN	MTN	TYPE	DET_SUF
LEXENTRY:	MOUNTAINS	MTNS	TYPE	DET_SUF
LEXENTRY:	MOUNTIN	MTN	TYPE	DET_SUF
LEXENTRY:	MS	Mississippi	PROV	DETACH
LEXENTRY:	MSN	MSN	TYPE	DET_SUF
LEXENTRY:	MSSN	MSN	TYPE	DET_SUF
LEXENTRY:	MT	MT	TYPE,WORD	DETACH,DET_SUF
LEXENTRY:	MT	Montana	PROV	DETACH
LEXENTRY:	MT.	MT	TYPE,WORD	DETACH,DET_SUF
LEXENTRY:	MTIN	MTN	TYPE	DET_SUF
LEXENTRY:	MTN	MTN	TYPE	DET_SUF
LEXENTRY:	MTNS	MTNS	TYPE	DET_SUF
LEXENTRY:	MTWY	MTWY	TYPE	DET_SUF
LEXENTRY:	MUSEUM	MUSEUM	PLACEN	DETACH
LEXENTRY:	N	NORTH	DIRECT,WORD	DETACH
LEXENTRY:	N.	NORTH	DIRECT,WORD	DETACH
LEXENTRY:	NA	NA	PLACEN	DETACH
LEXENTRY:	NC	North Carolina	PROV	DETACH
LEXENTRY:	NCK	NCK	TYPE	DET_SUF
LEXENTRY:	ND	North Dakota	PROV	DETACH
LEXENTRY:	NE	Nebraska	PROV	DETACH
LEXENTRY:	NE	NORTHEAST	DIRECT	DETACH
LEXENTRY:	NE.	NORTHEAST	DIRECT	DETACH
LEXENTRY:	NECK	NCK	TYPE	DET_SUF
LEXENTRY:	NH	New Hampshire	PROV	DETACH
LEXENTRY:	NINE	9	NUMBER	DETACH
LEXENTRY:	NINETEEN	19	NUMBER	DETACH
LEXENTRY:	NINETEENTH	19TH	WORD,ORD	DETACH
LEXENTRY:	NINETIETH	90TH	WORD,ORD	DETACH
LEXENTRY:	NINETY	90	NUMBER	DETACH
LEXENTRY:	NINTH	9TH	WORD,ORD	DETACH
LEXENTRY:	NJ	New Jersey	PROV	DETACH
LEXENTRY:	NM	New Mexico	PROV	DETACH
LEXENTRY:	NORTH	NORTH	DIRECT,WORD	DETACH
LEXENTRY:	NORTHEAST	NORTHEAST	DIRECT	DETACH
LEXENTRY:	NORTHWEST	NORTHWEST	DIRECT	DETACH
LEXENTRY:	NV	Nevada	PROV	DETACH
LEXENTRY:	NW	NORTHWEST	DIRECT	DETACH
LEXENTRY:	NW.	NORTHWEST	DIRECT	DETACH
LEXENTRY:	NY	New York	PROV	DETACH
LEXENTRY:	OFC	OFFICE	UNITH	DETACH
LEXENTRY:	OFFICE	OFFICE	PLACEN,UNITH	DETACH
LEXENTRY:	OH	Ohio	PROV	DETACH
LEXENTRY:	OK	Oklahoma	PROV	DETACH
LEXENTRY:	OLD	OLD	QUALIF	DETACH
LEXENTRY:	OLDE	OLDE	QUALIF	DETACH
LEXENTRY:	ONE	1	NUMBER	DETACH
LEXENTRY:	OPAS	OPAS	TYPE	DET_SUF
LEXENTRY:	OR	Oregon	PROV	DETACH
LEXENTRY:	ORCH	ORCH	TYPE	DET_SUF
LEXENTRY:	ORCHARD	ORCH	TYPE	DET_SUF
LEXENTRY:	ORCHRD	ORCH	TYPE	DET_SUF
LEXENTRY:	ORGANIZATION	ORGANIZATION	PLACEN	DETACH
LEXENTRY:	OVAL	OVAL	TYPE	DET_SUF
LEXENTRY:	OVERPASS	OPAS	TYPE	DET_SUF
LEXENTRY:	OVL	OVAL	TYPE	DET_SUF
LEXENTRY:	PA	Pennsylvania	PROV	DETACH
LEXENTRY:	PARK	PARK	PLACEN,TYPE	DETACH,DET_SUF
LEXENTRY:	PARKING	PARKING	PLACEN	DETACH
LEXENTRY:	PARKS	PARK	TYPE	DET_SUF
LEXENTRY:	PARKWAY	PKY	TYPE	DET_SUF
LEXENTRY:	PARKWAYS	PKY	TYPE	DET_SUF
LEXENTRY:	PARKWY	PKY	TYPE	DET_SUF
LEXENTRY:	PASS	PASS	TYPE	DET_SUF
LEXENTRY:	PASSAGE	PSGE	TYPE	DET_SUF
LEXENTRY:	PATH	PATH	TYPE	DET_SUF
LEXENTRY:	PATHS	PATH	TYPE	DET_SUF
LEXENTRY:	PENTHOUSE	PENTHOUSE	UNITH	DETACH
LEXENTRY:	PH	PENTHOUSE	UNITH	DETACH
LEXENTRY:	PH.	PENTHOUSE	UNITH	DETACH
LEXENTRY:	PIER	PIER	UNITH	DETACH
LEXENTRY:	PIKE	PIKE	TYPE	DET_SUF
LEXENTRY:	PIKES	PIKE	TYPE	DET_SUF
LEXENTRY:	PINE	PNE	TYPE	DET_SUF
LEXENTRY:	PINES	PNES	TYPE	DET_SUF
LEXENTRY:	PIZZA	PIZZA	PLACEN	DETACH
LEXENTRY:	PK	PARK	TYPE	DET_SUF
LEXENTRY:	PK.	PARK	TYPE	DET_SUF
LEXENTRY:	PKWAY	PKY	TYPE	DET_SUF
LEXENTRY:	PKWY	PKY	TYPE	DET_SUF
LEXENTRY:	PKWYS	PKY	TYPE	DET_SUF
LEXENTRY:	PKY	PKY	TYPE	DET_SUF
LEXENTRY:	PL	PL	TYPE	DET_SUF
LEXENTRY:	PL.	PL	TYPE	DET_SUF
LEXENTRY:	PLACE	PL	TYPE	DET_SUF
LEXENTRY:	PLAIN	PLN	TYPE	DET_SUF
LEXENTRY:	PLAINS	PLNS	TYPE	DET_SUF
LEXENTRY:	PLAZA	PLAZA	PLACEN	DETACH
LEXENTRY:	PLAZA	PLZ	TYPE	DET_SUF
LEXENTRY:	PLC	PLC	PLACEN	DETACH
LEXENTRY:	PLN	PLN	TYPE	DET_SUF
LEXENTRY:	PLNS	PLNS	TYPE	DET_SUF
LEXENTRY:	PLZ	PLZ	TYPE	DET_SUF
LEXENTRY:	PLZ.	PLZ	TYPE	DET_SUF
LEXENTRY:	PLZA	PLZ	TYPE	DET_SUF
LEXENTRY:	PNE	PNE	TYPE	DET_SUF
LEXENTRY:	PNES	PNES	TYPE	DET_SUF
LEXENTRY:	POINT	PT	TYPE	DET_SUF
LEXENTRY:	POINTS	PTS	TYPE	DET_SUF
LEXENTRY:	POLICE	POLICE	PLACEN	DETACH
LEXENTRY:	PORT	PRT	TYPE	DET_SUF
LEXENTRY:	PORTS	PRTS	TYPE	DET_SUF
LEXENTRY:	PR	PR	TYPE	DET_SUF
LEXENTRY:	PRAIRIE	PR	TYPE	DET_SUF
LEXENTRY:	PRARIE	PR	TYPE	DET_SUF
LEXENTRY:	PRK	PARK	TYPE	DET_SUF
LEXENTRY:	PRR	PR	TYPE	DET_SUF
LEXENTRY:	PRT	PRT	TYPE	DET_SUF
LEXENTRY:	PRTS	PRTS	TYPE	DET_SUF
LEXENTRY:	PSGE	PSGE	TYPE	DET_SUF
LEXENTRY:	PT	PT	TYPE	DET_SUF
LEXENTRY:	PT.	PT	TYPE	DET_SUF
LEXENTRY:	PTS	PTS	TYPE	DET_SUF
LEXENTRY:	RAD	RADL	TYPE	DET_SUF
LEXENTRY:	RADIAL	RADL	TYPE	DET_SUF
LEXENTRY:	RADIEL	RADL	TYPE	DET_SUF
LEXENTRY:	RADL	RADL	TYPE	DET_SUF
LEXENTRY:	RAMP	RAMP	TYPE	DET_SUF
LEXENTRY:	RANCH	RNCH	TYPE	DET_SUF
LEXENTRY:	RANCHES	RNCH	TYPE	DET_SUF
LEXENTRY:	RAPID	RPD	TYPE	DET_SUF
LEXENTRY:	RAPIDS	RPDS	TYPE	DET_SUF
LEXENTRY:	RD	RD	TYPE	DET_SUF
LEXENTRY:	RD OF	ROAD OF	WORD	DETACH
LEXENTRY:	RD.	RD	TYPE	DET_SUF
LEXENTRY:	RD. OF	ROAD OF	WORD	DETACH
LEXENTRY:	RDG	RDG	TYPE	DET_SUF
LEXENTRY:	RDGE	RDG	TYPE	DET_SUF
LEXENTRY:	RDGS	RDGS	TYPE	DET_SUF
LEXENTRY:	RDS	RDS	TYPE	DET_SUF
LEXENTRY:	REAR	REAR	UNITH	DETACH
LEXENTRY:	RENTAL	RENTAL	PLACEN	DETACH
LEXENTRY:	REPAIR	REPAIR	PLACEN	DETACH
LEXENTRY:	REST	RST	TYPE	DET_SUF
LEXENTRY:	RESTAURANT	RESTAURANT	PLACEN	DETACH
LEXENTRY:	RI	Rhode Island	PROV	DETACH
LEXENTRY:	RIDGE	RDG	TYPE	DET_SUF
LEXENTRY:	RIDGES	RDGS	TYPE	DET_SUF
LEXENTRY:	RIV	RIV	TYPE	DET_SUF
LEXENTRY:	RIVER	RIV	TYPE	DET_SUF
LEXENTRY:	RIVR	RIV	TYPE	DET_SUF
LEXENTRY:	RM	ROOM	UNITH	DETACH
LEXENTRY:	RM.	ROOM	UNITH	DETACH
LEXENTRY:	RNCH	RNCH	TYPE	DET_SUF
LEXENTRY:	RNCHS	RNCH	TYPE	DET_SUF
LEXENTRY:	ROAD	RD	TYPE	DET_SUF
LEXENTRY:	ROAD OF	ROAD OF	WORD	DETACH
LEXENTRY:	ROADS	RDS	TYPE	DET_SUF
LEXENTRY:	ROOM	ROOM	UNITH	DETACH
LEXENTRY:	ROUTE	RT	ROAD	DET_PRE
LEXENTRY:	ROW	ROW	TYPE	DET_SUF
LEXENTRY:	RPD	RPD	TYPE	DET_SUF
LEXENTRY:	RPDS	RPDS	TYPE	DET_SUF
LEXENTRY:	RR	RR	RR	DETACH
LEXENTRY:	RST	RST	TYPE	DET_SUF
LEXENTRY:	RT	RT	ROAD	DET_PRE
LEXENTRY:	RT.	RT	ROAD	DET_PRE
LEXENTRY:	RTE	RT	ROAD	DET_PRE
LEXENTRY:	RUE	RUE	TYPE	DET_SUF
LEXENTRY:	RUN	RUN	TYPE	DET_SUF
LEXENTRY:	RURAL ROUTE	RR	RR	DETACH
LEXENTRY:	RVR	RIV	TYPE	DET_SUF
LEXENTRY:	S	SOUTH	DIRECT,WORD	DETACH
LEXENTRY:	S.	SOUTH	DIRECT,WORD	DETACH
LEXENTRY:	SAINT	ST	WORD	DETACH
LEXENTRY:	SC	South Carolina	PROV	DETACH
LEXENTRY:	SCHOOL	SCHOOL	PLACEN	DETACH
LEXENTRY:	SD	South Dakota	PROV	DETACH
LEXENTRY:	SE	SOUTHEAST	DIRECT	DETACH
LEXENTRY:	SE.	SOUTHEAST	DIRECT	DETACH
LEXENTRY:	SECOND	2ND	WORD,ORD	DETACH
LEXENTRY:	SERVICE	SERVICE	PLACEN	DETACH
LEXENTRY:	SEVEN	7	NUMBER	DETACH
LEXENTRY:	SEVENTEEN	17	NUMBER	DETACH
LEXENTRY:	SEVENTEENTH	17TH	WORD,ORD	DETACH
LEXENTRY:	SEVENTH	7TH	WORD,ORD	DETACH
LEXENTRY:	SEVENTIETH	70TH	WORD,ORD	DETACH
LEXENTRY:	SEVENTY	70	NUMBER	DETACH
LEXENTRY:	SHL	SHL	TYPE	DET_SUF
LEXENTRY:	SHLS	SHLS	TYPE	DET_SUF
LEXENTRY:	SHOAL	SHL	TYPE	DET_SUF
LEXENTRY:	SHOALS	SHLS	TYPE	DET_SUF
LEXENTRY:	SHOAR	SHR	TYPE	DET_SUF
LEXENTRY:	SHOARS	SHRS	TYPE	DET_SUF
LEXENTRY:	SHOP	SHOP	PLACEN	DETACH
LEXENTRY:	SHORE	SHR	TYPE	DET_SUF
LEXENTRY:	SHORES	SHRS	TYPE	DET_SUF
LEXENTRY:	SHR	SHR	TYPE	DET_SUF
LEXENTRY:	SHRS	SHRS	TYPE	DET_SUF
LEXENTRY:	SIDE	SIDE	UNITH	DETACH
LEXENTRY:	SIX	6	NUMBER	DETACH
LEXENTRY:	SIXTEEN	16	NUMBER	DETACH
LEXENTRY:	SIXTEENTH	16TH	WORD,ORD	DETACH
LEXENTRY:	SIXTH	6TH	WORD,ORD	DETACH
LEXENTRY:	SIXTIETH	60TH	WORD,ORD	DETACH
LEXENTRY:	SIXTY	60	NUMBER	DETACH
LEXENTRY:	SKWY	SKWY	TYPE	DET_SUF
LEXENTRY:	SKYWAY	SKWY	TYPE	DET_SUF
LEXENTRY:	SLIP	SLIP	UNITH	DETACH
LEXENTRY:	SMT	SMT	TYPE	DET_SUF
LEXENTRY:	SOUTH	SOUTH	DIRECT,WORD	DETACH
LEXENTRY:	SOUTHEAST	SOUTHEAST	DIRECT	DETACH
LEXENTRY:	SOUTHWEST	SOUTHWEST	DIRECT	DETACH
LEXENTRY:	SPACE	SPACE	UNITH	DETACH
LEXENTRY:	SPC	SPACE	UNITH	DETACH
LEXENTRY:	SPG	SPG	TYPE	DET_SUF
LEXENTRY:	SPGS	SPGS	TYPE	DET_SUF
LEXENTRY:	SPNG	SPG	TYPE	DET_SUF
LEXENTRY:	SPNGS	SPGS	TYPE	DET_SUF
LEXENTRY:	SPRING	SPG	TYPE	DET_SUF
LEXENTRY:	SPRINGS	SPGS	TYPE	DET_SUF
LEXENTRY:	SPRNG	SPG	TYPE	DET_SUF
LEXENTRY:	SPRNGS	SPGS	TYPE	DET_SUF
LEXENTRY:	SPUR	SPUR	TYPE	DET_SUF
LEXENTRY:	SPURS	SPUR	TYPE	DET_SUF
LEXENTRY:	SQ	SQ	TYPE	DET_SUF
LEXENTRY:	SQR	SQ	TYPE	DET_SUF
LEXENTRY:	SQRE	SQ	TYPE	DET_SUF
LEXENTRY:	SQS	SQS	TYPE	DET_SUF
LEXENTRY:	SQU	SQ	TYPE	DET_SUF
LEXENTRY:	SQUARE	SQUARE	PLACEN	DETACH
LEXENTRY:	SQUARE	SQ	TYPE	DET_SUF
LEXENTRY:	SQUARES	SQS	TYPE	DET_SUF
LEXENTRY:	ST	ST	TYPE,WORD	DETACH,DET_SUF
LEXENTRY:	ST OF	STREET OF	WORD	DETACH
LEXENTRY:	ST.	ST	TYPE,WORD	DETACH,DET_SUF
LEXENTRY:	ST. OF	STREET OF	WORD	DETACH
LEXENTRY:	STA	STA	TYPE	DET_SUF
LEXENTRY:	STATE ROUTE	STATE ROUTE	ROAD	DETACH
LEXENTRY:	STATE RTE	STATE RTE	ROAD	DETACH
LEXENTRY:	STATE RT	STATE RT	ROAD	DETACH
LEXENTRY:	STATE ROAD	STATE ROAD	ROAD	DETACH
LEXENTRY:	STATE RD	STATE RD	ROAD	DETACH
LEXENTRY:	SR	SR	ROAD	DETACH
LEXENTRY:	STATION	STATION	PLACEN	DETACH
LEXENTRY:	STATION	STA	TYPE	DET_SUF
LEXENTRY:	STATN	STA	TYPE	DET_SUF
LEXENTRY:	STE	SUITE	UNITH	DETACH
LEXENTRY:	STE.	SUITE	UNITH	DETACH
LEXENTRY:	STN	STA	TYPE	DET_SUF
LEXENTRY:	STOP	STOP	UNITH	DETACH
LEXENTRY:	STR	ST	TYPE	DET_SUF
LEXENTRY:	STR.	ST	TYPE	DET_SUF
LEXENTRY:	STRA	STRA	TYPE	DET_SUF
LEXENTRY:	STRAV	STRA	TYPE	DET_SUF
LEXENTRY:	STRAVE	STRA	TYPE	DET_SUF
LEXENTRY:	STRAVEN	STRA	TYPE	DET_SUF
LEXENTRY:	STRAVENUE	STRA	TYPE	DET_SUF
LEXENTRY:	STRAVN	STRA	TYPE	DET_SUF
LEXENTRY:	STREAM	STRM	TYPE	DET_SUF
LEXENTRY:	STREET	ST	TYPE	DET_SUF
LEXENTRY:	STREET OF	STREET OF	WORD	DETACH
LEXENTRY:	STREETS	STS	TYPE	DET_SUF
LEXENTRY:	STREME	STRM	TYPE	DET_SUF
LEXENTRY:	STRM	STRM	TYPE	DET_SUF
LEXENTRY:	STRT	ST	TYPE	DET_SUF
LEXENTRY:	STRVN	STRA	TYPE	DET_SUF
LEXENTRY:	STRVNUE	STRA	TYPE	DET_SUF
LEXENTRY:	STS	STS	TYPE	DET_SUF
LEXENTRY:	STUDIO	STUDIO	PLACEN	DETACH
LEXENTRY:	SUITE	SUITE	UNITH	DETACH
LEXENTRY:	SUMIT	SMT	TYPE	DET_SUF
LEXENTRY:	SUMITT	SMT	TYPE	DET_SUF
LEXENTRY:	SUMMIT	SMT	TYPE	DET_SUF
LEXENTRY:	SW	SOUTHWEST	DIRECT	DETACH
LEXENTRY:	SW.	SOUTHWEST	DIRECT	DETACH
LEXENTRY:	TEN	10	NUMBER	DETACH
LEXENTRY:	TENTH	10TH	WORD,ORD	DETACH
LEXENTRY:	TER	TER	TYPE,WORD	DET_SUF
LEXENTRY:	TERR	TER	TYPE,WORD	DET_SUF
LEXENTRY:	TERRACE	TER	TYPE,WORD	DET_SUF
LEXENTRY:	THEATRE	THEATRE	PLACEN,WORD	DETACH
LEXENTRY:	THIRD	3RD	WORD,ORD	DETACH
LEXENTRY:	THIRTEEN	13	NUMBER	DETACH
LEXENTRY:	THIRTEENTH	13TH	WORD,ORD	DETACH
LEXENTRY:	THIRTIETH	30TH	WORD,ORD	DETACH
LEXENTRY:	THIRTY	30	NUMBER	DETACH
LEXENTRY:	THREE	3	NUMBER	DETACH
LEXENTRY:	THROUGHWAY	TRWY	TYPE	DET_SUF
LEXENTRY:	TN	Tennessee	PROV	DETACH
LEXENTRY:	TPK	TPKE	TYPE	DET_SUF
LEXENTRY:	TPKE	TPKE	TYPE	DET_SUF
LEXENTRY:	TR	TRL	TYPE	DET_SUF
LEXENTRY:	TRACE	TRCE	TYPE	DET_SUF
LEXENTRY:	TRACES	TRCE	TYPE	DET_SUF
LEXENTRY:	TRACK	TRAK	TYPE	DET_SUF
LEXENTRY:	TRACKS	TRAK	TYPE	DET_SUF
LEXENTRY:	TRAFFICWAY	TRFY	TYPE	DET_SUF
LEXENTRY:	TRAIL	TRL	TYPE	DET_SUF
LEXENTRY:	TRAILER	TRAILER	UNITH	DETACH
LEXENTRY:	TRAILS	TRL	TYPE	DET_SUF
LEXENTRY:	TRAK	TRAK	TYPE	DET_SUF
LEXENTRY:	TRCE	TRCE	TYPE	DET_SUF
LEXENTRY:	TRFY	TRFY	TYPE	DET_SUF
LEXENTRY:	TRK	TRAK	TYPE	DET_SUF
LEXENTRY:	TRKS	TRAK	TYPE	DET_SUF
LEXENTRY:	TRL	TRL	TYPE	DET_SUF
LEXENTRY:	TRLR	TRAILER	UNITH	DETACH
LEXENTRY:	TRLS	TRL	TYPE	DET_SUF
LEXENTRY:	TRNPK	TPKE	TYPE	DET_SUF
LEXENTRY:	TRPK	TPKE	TYPE	DET_SUF
LEXENTRY:	TRUST	TRUST	PLACEN	DETACH
LEXENTRY:	TRWY	TRWY	TYPE	DET_SUF
LEXENTRY:	TUNEL	TUNL	TYPE	DET_SUF
LEXENTRY:	TUNL	TUNL	TYPE	DET_SUF
LEXENTRY:	TUNLS	TUNL	TYPE	DET_SUF
LEXENTRY:	TUNNEL	TUNL	TYPE	DET_SUF
LEXENTRY:	TUNNELS	TUNL	TYPE	DET_SUF
LEXENTRY:	TUNNL	TUNL	TYPE	DET_SUF
LEXENTRY:	TURNPIKE	TPKE	TYPE	DET_SUF
LEXENTRY:	TURNPK	TPKE	TYPE	DET_SUF
LEXENTRY:	TWELFTH	12TH	WORD,ORD	DETACH
LEXENTRY:	TWELVE	12	NUMBER	DETACH
LEXENTRY:	TWENTIETH	20TH	WORD,ORD	DETACH
LEXENTRY:	TWENTY	20	NUMBER	DETACH
LEXENTRY:	TWO	2	NUMBER	DETACH
LEXENTRY:	TX	Texas	PROV	DETACH
LEXENTRY:	US RT	US RT	ROAD	DETACH
LEXENTRY:	U.S.	UNITED STATES	NATION	DETACH
LEXENTRY:	U.S.A.	UNITED STATES	NATION	DETACH
LEXENTRY:	UN	UN	TYPE	DET_SUF
LEXENTRY:	UN.	UN	TYPE	DET_SUF
LEXENTRY:	UNDERPASS	UPAS	TYPE	DET_SUF
LEXENTRY:	UNION	UN	TYPE	DET_SUF
LEXENTRY:	UNIONS	UNS	TYPE	DET_SUF
LEXENTRY:	UNIT	UNIT	UNITH	DETACH
LEXENTRY:	UNITED STATES	UNITED STATES	NATION	DETACH
LEXENTRY:	UNITED STATES OF AMERICA	UNITED STATES	NATION	DETACH
LEXENTRY:	UNIVERSITY	UNIVERSITY	PLACEN	DETACH
LEXENTRY:	UNS	UNS	TYPE	DET_SUF
LEXENTRY:	UPAS	UPAS	TYPE	DET_SUF
LEXENTRY:	UPPER	UPPER	UNITH	DETACH
LEXENTRY:	UPPR	UPPER	UNITH	DETACH
LEXENTRY:	US	UNITED STATES	NATION	DETACH
LEXENTRY:	USA	UNITED STATES	NATION	DETACH
LEXENTRY:	UT	Utah	PROV	DETACH
LEXENTRY:	VA	Virginia	PROV	DETACH
LEXENTRY:	VALLEY	VLY	TYPE	DET_SUF
LEXENTRY:	VALLEYS	VLYS	TYPE	DET_SUF
LEXENTRY:	VALLY	VLY	TYPE	DET_SUF
LEXENTRY:	VDCT	VIA	TYPE	DET_SUF
LEXENTRY:	VIA	VIA	TYPE	DET_SUF
LEXENTRY:	VIADCT	VIA	TYPE	DET_SUF
LEXENTRY:	VIADUCT	VIA	TYPE	DET_SUF
LEXENTRY:	VIEW	VW	TYPE	DET_SUF
LEXENTRY:	VIEWS	VWS	TYPE	DET_SUF
LEXENTRY:	VILL	VLG	TYPE	DET_SUF
LEXENTRY:	VILLAG	VLG	TYPE	DET_SUF
LEXENTRY:	VILLAGE	VLG	TYPE	DET_SUF
LEXENTRY:	VILLAGES	VLGS	TYPE	DET_SUF
LEXENTRY:	VILLE	VL	TYPE	DET_SUF
LEXENTRY:	VILLG	VLG	TYPE	DET_SUF
LEXENTRY:	VILLIAGE	VLG	TYPE	DET_SUF
LEXENTRY:	VIS	VIS	TYPE	DET_SUF
LEXENTRY:	VIST	VIS	TYPE	DET_SUF
LEXENTRY:	VISTA	VIS	TYPE	DET_SUF
LEXENTRY:	VL	VL	TYPE	DET_SUF
LEXENTRY:	VLG	VLG	TYPE	DET_SUF
LEXENTRY:	VLGS	VLGS	TYPE	DET_SUF
LEXENTRY:	VLLY	VLY	TYPE	DET_SUF
LEXENTRY:	VLY	VLY	TYPE	DET_SUF
LEXENTRY:	VLYS	VLYS	TYPE	DET_SUF
LEXENTRY:	VST	VIS	TYPE	DET_SUF
LEXENTRY:	VSTA	VIS	TYPE	DET_SUF
LEXENTRY:	VT	Vermont	PROV	DETACH
LEXENTRY:	VW	VW	TYPE	DET_SUF
LEXENTRY:	VWS	VWS	TYPE	DET_SUF
LEXENTRY:	W	WEST	DIRECT,WORD	DETACH
LEXENTRY:	W.	WEST	DIRECT,WORD	DETACH
LEXENTRY:	WA	Washington	PROV	DETACH
LEXENTRY:	WALK	WALK	TYPE	DET_SUF
LEXENTRY:	WALKS	WALK	TYPE	DET_SUF
LEXENTRY:	WALL	WALL	TYPE	DET_SUF
LEXENTRY:	WAY	WAY	TYPE	DET_SUF
LEXENTRY:	WAYS	WAYS	TYPE	DET_SUF
LEXENTRY:	WELL	WL	TYPE	DET_SUF
LEXENTRY:	WELLS	WLS	TYPE	DET_SUF
LEXENTRY:	WEST	WEST	DIRECT,WORD	DETACH
LEXENTRY:	WI	Wisconsin	PROV	DETACH
LEXENTRY:	WL	WL	TYPE	DET_SUF
LEXENTRY:	WLS	WLS	TYPE	DET_SUF
LEXENTRY:	WV	West Virginia	PROV	DETACH
LEXENTRY:	WY	Wyoming	PROV	DETACH
LEXENTRY:	WY	WAY	TYPE	DET_SUF
LEXENTRY:	XING	XING	TYPE	DET_SUF
LEXENTRY:	XRD	XRD	TYPE	DET_SUF
');


drop extension address_standardizer;
create extension address_standardizer;

-- select * from pg_backend_pid();

select * from as_standardize(
    '11 radcliff rd, north chelmsford, ma 01863-2313 usa', 
    (select grammar from test_data where id=1), 
    (select lexicon from test_data where id=1), 
    'en', 
    'PUNCT,SPACE,DASH');
    
    
select * from as_standardize(
    '11 radcliff rd, north chelmsford, ma 01863-2313 usa', 
    (select grammar from test_data where id=1), 
    (select lexicon from test_data where id=1), 
    'en', 
    'PUNCT,SPACE,DASH');
    

--------------------------------------------------------------------
-- The following two queries assume you have loaded sample-data.sql
--------------------------------------------------------------------

select * from as_standardize(
    '11 radcliff rd north chelmsford ma 01863', 
    (select grammar from as_config where countrycode='us'), 
    (select lexicon from as_config where countrycode='us'), 
    'en_US', 
    (select filter from as_config where countrycode='us')
);

select * from as_standardize(
    'Kastanievej 15, 2, Agerskov 8660 SKANDERBORG DK', 
    (select grammar from as_config where countrycode='dk'), 
    (select lexicon from as_config where countrycode='dk'), 
    'dk', 
    (select filter from as_config where countrycode='dk')
);