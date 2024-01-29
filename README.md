# Supporting-Evidence-for-OLAC-Provenance
This repository contains the data and the methods for querying the data related to the OLAC Provenance paper


## Informatic tasks

I need to answer the following question: _How many Records are in the data set?_

I make the statement: There were **X** records in the data set. I based this on a count of the following string which only appears at the beginning of a record.

`grep -n -i '<record xmlns=' ListRecords-20210708.xml | wc -l`

result: 443,217

<hr>

_How many Provenance statements are in the data set?_

Each record may contain one or more provenance statements. I want to know how many there are regardless of which records they are attached to.

To make a rough and dirty extraction I used:

`grep -n -i -C 0 'dcterms:provenance' ListRecords-20210708.xml | wc -l > list-of-provenance-statements.txt`

This file cuts off multi-line instances a slightly better line, which splits on the end tag is:

`grep -n -i -C 0 '/dcterms:provenance' ListRecords-20210708.xml | wc -l > list-of-provenance-statements.txt` 

Both solutions report 2924 lines with "provenance". This is a bit confusing because of the numbers in the following section.

<hr>
Just because there is a special field for provenance statements doesn't mean that that field is always used for provenance statements. For example, many times people stick these in the description field. So I need to check for mentions of provenance outside of the provenance field.

For the claim that there are **X** number of references within the XML file to the case insensitive term "Provenance" the following was used: 

`grep -n -i Provenance ListRecords-20210708.xml | wc -l`

result: 1876

53 instances of the word "provenance" occurs in elements across the records which are not in the '<dct:provenance> element. These occurred in the following:

* 37 <dc:subject> tags,
* 1 instance of <dcterms:bibliographicCitation>,
* 1 instance of <dcterms:tableOfContents>,
* 1 instance of <dc:format>,
* 12 instances of <dc:description> with one <dc:description> containing two instances of the of the term.


If I parsed things correctly, which I think I have, there should be 1823 instances of the <dct:provance> element. But the following questions remain:

	1. On how many individual records do these elements appear?
	2. And then on how many records with a <dc:description> element also have a <dct:provance> element? That is which data providers are aware of both and using both elements?

There appears to be 551,722 uses of the dc:description element. This was found out by using the following line.

`grep -i '/dc:description' ListRecords-20210708.xml | wc -l`

Clearly, some records have more than one instance of <dc:description>, in fact some records, like those from SOAS, have 5 instances of <dc:description> per record.

	1. So, on how many records does <dc:description> appear?
	2. These uses of <dc:description>, how many different data providers are there across them? (Total data providers - data providers using <dc:description> = **X**)

Of the data providers: 

* How many of the data providers use provenance and to what percentage of their records?
* How many of the data providers use description to what percentage of their records?
* How many use provenance and description to what percentage of their records respective records? (E.g. if SOAS uses both then what percentage of their records use both...)
* Is there a disjunct? That is are there providers which use provenance but not description?

To get at this information I think a spreadsheet or CSV file is needed.
The following information is desired:

OAI-ID | dc:description | dct:provenance | other tag
---|---|---|---
record/header/identifier|record/metadata/olac:olac/dc:description|record/metadata/olac:olac/dct:provenance|record/metadata/olac:olac/dc*(provenance)

For each record under `ListRecords` we want to match the content of `<record><header><identifier>` and one or more of: `<record><metadata><olac:olac><dct:provenance>` || `<record><metadata><olac:olac><dc:description>`



## Indirect indications of Provenance

There are two other ways to deduce that provenance should have some record in it. The first is through roles. The second is through relations.

For example, several roles can be indicated through a record (See OLAC Roles and MARC Roles). Roles come in different classes, first there are creator roles, second there are cutorial and augmenter roles, and third there are institutional roles. For example, a creator role might be "videographer" while an augmenter role might be "production manager", "principle investigator", "researcher". Finally an institutional role might be "depositor". 

By understanding the creation narrative of unique artifacts we might come to learn that someone created something (e.g., a recording). Then a second party collected their works when they retired. This second person is the "collector" or "assembler". Then the work, as part of a collection was turned over to a stewardship organization. From the organization's perspective then the "depositor" is indicated. So here we have some indication of a chain of custody. This should be part of the provenance statement.

`grep -n -i -C 25 'olac:code="collector"' ListRecords-20210708.xml`

`grep -n -i -C 25 'olac:code="depositor"' ListRecords-20210708.xml`


The second indirect method is though relations. Several relations exist. For example, dc:source might have information indicating a source resource. In this kind of situation we can surmise something about the creation event and the delta between the source artifact and the current artifact. The articulation of this detail is part of the provenance narrative. Source is not the only relationship. For example, the relationships dct:replaces, dct:isreplacedby, should also come with provenance statements related to deltas. 

`grep -n -i -C 25 'dc:source' ListRecords-20210708.xml`

In a different sense if we look at dct:isVersionOf, dct:hasVersion, dct:isFormatOf, and dct:hasFormat these relationships are indicative of Expression and Manifestation changes. In these cases a provenance statement fitting to the explanation of how they related to the work or another Expression or Manifestation is fitting.

A third kind of relationship is the references relationship. Some descriptions reference an accession records. Links to these accession Records even if they are not online are suitable to appear in the references section.

`grep -n -i 'accession' ListRecords-20210708.xml`


`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 '/dcterms:provenance' ListRecords-20210708.xml | wc -l`

2924

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 'dcterms:provenance' ListRecords-20210708.xml | wc -l`
2924

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 'dcterms:source' ListRecords-20210708.xml | wc -l`
0

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 'dc:source' ListRecords-20210708.xml | wc -l`
6023

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 'replacedby' ListRecords-20210708.xml | wc -l`
2323

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 'replaces' ListRecords-20210708.xml | wc -l`
6521

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 'depositor' ListRecords-20210708.xml | wc -l`
81068

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 '"depositor' ListRecords-20210708.xml | wc -l`
63588

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 '"depositor"' ListRecords-20210708.xml | wc -l`
63588

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 '"collector"' ListRecords-20210708.xml | wc -l`
0

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 'collect' ListRecords-20210708.xml | wc -l`
111995

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 'hasversion' ListRecords-20210708.xml | wc -l`
7538

`greenlantern@GreenLantern:/mnt/files/OLAC-Collections$ grep -n -i -C 0 'hasformat' ListRecords-20210708.xml | wc -l`
520


OLAC Role Application Recomendation
