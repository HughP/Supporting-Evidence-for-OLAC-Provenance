# Supporting-Evidence-for-OLAC-Provenance
This repository contains the data and the methods for querying the data related to the OLAC Provenance paper


## Informatic tasks

I need to answer the following qestion: _How many Records are in the dataset?_

I make the satement: There were **X** records in the data set. I based this on a count of the following string which only appears at the begining of a record.

`grep -n -i '<record xmlns=' ListRecords-20210708.xml | wc -l`

result: 443,217

<hr>

_How many Provenance statements are in the dataset?_

Each record may contain one or more provenance statements. I want to know how many there are regardless of which records they are attached to.

To make a rough and dirty extration I used:

`grep -n -i -C 0 'dcterms:provenance' ListRecords-20210708.xml | wc -l > list-of-provenance-statements.txt`

This file cuts off multi-line instances a slightly better line, which splits on the end tag is:

`grep -n -i -C 0 '/dcterms:provenance' ListRecords-20210708.xml | wc -l > list-of-provenance-statements.txt` 

Both solutions report 2924 lines with "provenance". This is a bit confusing because of the numbers in the following section.

<hr>
Just because there is a special field for provenance statements doesn't mean that that field is always used for provenance statements. For example, many times people stick these in the description field. So I need to check for mentions of provenance outside of the provenance field.

For the claim that there are **X** number of references within the XML file to the case insensitive term "Provenance" the following was used: 

`grep -n -i Provenance ListRecords-20210708.xml | wc -l`

result: 1876

53 instances of the word "provenance" occurs in elements across the records which are not in the '<dct:provenance> element. These occured in the following:

* 37 <dc:subject> tags,
* 1 instance of <dcterms:bibliographicCitation>,
* 1 instance of <dcterms:tableOfContents>,
* 1 instance of <dc:format>,
* 12 instances of <dc:description> with one <dc:description> containing two instances of the of the term.


If I parsed things correctly, which I think I have, there should be 1823 instances of the <dct:provance> element. But the following qestions remain:

	1. On how many individual records do these elements apear?
	2. And then on how many records with a <dc:description> element also have a <dct:provance> element? That is which data providers are aware of both and using both elements?

There appears to be 551,722 uses of the dc:description element. This was found out by using the following line.

`grep -i '/dc:description' ListRecords-20210708.xml | wc -l`

Clearly, some records have more than one instance of <dc:description>, infact some records, like those from SOAS, have 5 instances of <dc:description> per record.

	1. So, on how many records does <dc:description> appear?
	2. These uses of <dc:description>, how many differnet data providers are there across them? (Total data providers - data providers using <dc:description> = **X**)

Of the data providers: 

* How many of the data providers use provenance and to what percentage of their records?
* How many of the data providers use description to what percentage of their records?
* How many use provenance and description to what percentage of their records respetive records? (E.g. if SOAS uses both then what percentage of their records use both...)
* Is there a disjnct? That is are there providers which use provenance but not description?

To get at this information I think a spreadsheet or CSV file is needed.
The following information is desired:

OAI-ID | dc:description | dct:provenance | other tag
---|---|---|---
record/header/identifier|record/metadata/olac:olac/dc:description|record/metadata/olac:olac/dct:provenance|record/metadata/olac:olac/dc*(provenance)

For each record under `ListRecords` we want to match the content of `<record><header><identifier>` and one or more of: `<record><metadata><olac:olac><dct:provenance>` || `<record><metadata><olac:olac><dc:description>`

