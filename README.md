# Supporting-Evidence-for-OLAC-Provenance
This repository contains the data and the methods for querying the data related to the OLAC Provenance paper.

## Record sourcing
Illustrative records for the paper can be found at `OLAC-Example-Records/`. There are four records. Three are from the 18 July 2021 data set, the other is from the 10 August 2011 data set. Records contain the date of their last harvest in thier names and internally in the XML.

## Usage
Initial exploration of the data was done using the 8 July 2021 dataset. Publication version used the 18 July 2021 data set. (https://zenodo.org/records/5112131)

I had to update my GB allocation to RAM by using:
`export _JAVA_OPTIONS="-Xmx12g"`
and then to check it `java -XshowSettings:vm `
and then to generate the stats: `saxonb-xslt -xsl:OlacStats.xsl -s:ListRecords-20210718.xml -o:prov-stats.xhtml `

## Initial Exploration and questions asked

### Record Counts

I need to answer the following question: _How many Records are in the data set?_

I make the statement: There were **X** records in the data set. I based this on a count of the following string which only appears at the beginning of a record.

`grep -n -i '<record xmlns=' ListRecords-20210708.xml | wc -l`

result 8 July: 443,217
result 18 July: 443,458

<hr>

_How many Provenance statements are in the data set?_

Each record may contain one or more provenance statements. I want to know how many there are regardless of which records they are attached to.

To make a rough and dirty extraction I used:

`grep -n -i -C 0 'dcterms:provenance' ListRecords-20210708.xml | wc -l > list-of-provenance-statements.txt`

`grep -n -i -C 0 'dcterms:provenance' ListRecords-20210718.xml | wc -l > list-of-provenance-statements-18.txt`

results 18 July: 2924

This file cuts off multi-line instances a slightly better line, which splits on the end tag is:

`grep -n -i -C 0 '/dcterms:provenance' ListRecords-20210708.xml | wc -l > list-of-provenance-statements.txt` 

`grep -n -i -C 0 '/dcterms:provenance' ListRecords-20210718.xml | wc -l > list-of-provenance-statements.txt` 

Both solutions report 2924 lines with "provenance". This is a bit confusing because of the numbers in the following section.

<hr>
Just because there is a special field for provenance statements doesn't mean that that field is always used for provenance statements. For example, many times people stick these in the description field. So I need to check for mentions of provenance outside of the provenance field.

For the claim that there are **X** number of references within the XML file to the case insensitive term "Provenance" the following was used: 

`grep -n -i Provenance ListRecords-20210708.xml | wc -l`

result 8 July: 1876
result 18 July: 1876

53 instances of the word "provenance" occurs in elements across the records which are not in the '<dct:provenance> element. These occurred in the following:

* 37 <dc:subject> tags,
* 1 instance of <dcterms:bibliographicCitation>,
* 1 instance of <dcterms:tableOfContents>,
* 1 instance of <dc:format>,
* 12 instances of <dc:description> with one <dc:description> containing two instances of the of the term.


If I parsed things correctly, which I think I have, there should be 1823 instances of the <dct:provance> element. But the following questions remain:

	1. On how many individual records do these elements appear?
	2. And then on how many records with a <dc:description> element also have a <dct:provance> element? That is which data providers are aware of both and using both elements?

There appears to be 551,722 uses of the dc:description element (8 July). This was found out by using the following line.

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

There are several other ways to deduce that provenance should have some record in it. The first is through roles. The second is through relations. The third is through dates. The fourth is through `accrualMethod`, an element which talks about how things were recieved. 


### Roles

For example, several roles can be indicated through a record (See OLAC Roles and MARC Roles). Roles come in different classes, first there are creator roles, second there are cutorial and augmenter roles, and third there are institutional roles. For example, a creator role might be "videographer" while an augmenter role might be "production manager", "principle investigator", "researcher". Finally an institutional role might be "depositor". 

By understanding the creation narrative of unique artifacts we might come to learn that someone created something (e.g., a recording). Then a second party collected their works when they retired. This second person is the "collector" or "assembler". Then the work, as part of a collection was turned over to a stewardship organization. From the organization's perspective then the "depositor" is indicated. So here we have some indication of a chain of custody. This should be part of the provenance statement.

`grep -n -i -C 25 'olac:code="collector"' ListRecords-20210708.xml`

`grep -n -i -C 25 'olac:code="depositor"' ListRecords-20210708.xml`

`grep -n -i -C 25 'depositor' ListRecords-20210708.xml | wc -l`

1457196

`grep -n -i -C 25 'olac:code="depositor"' ListRecords-20210708.xml | wc -l`

1332776

`grep -n -i -C 25 'olac:code="collector"' ListRecords-20210708.xml | wc -l`

0

`grep -n -i -C 0 'collect' ListRecords-20210708.xml | wc -l`

111995

### Relations

The second indirect method is though relations. Several relations exist. For example, dc:source might have information indicating a source resource. In this kind of situation we can surmise something about the creation event and the delta between the source artifact and the current artifact. The articulation of this detail is part of the provenance narrative. Source is not the only relationship. For example, the relationships dct:replaces, dct:isreplacedby, should also come with provenance statements related to deltas. 

`grep -n -i -C 25 'dc:source' ListRecords-20210708.xml`

In a different sense if we look at dct:isVersionOf, dct:hasVersion, dct:isFormatOf, and dct:hasFormat these relationships are indicative of Expression and Manifestation changes. In these cases a provenance statement fitting to the explanation of how they related to the work or another Expression or Manifestation is fitting.

`grep -n -i -C 0 'hasversion' ListRecords-20210708.xml | wc -l`

result 8 July: 7538
result 18 July: 7548

`grep -n -i -C 0 'hasformat' ListRecords-20210708.xml | wc -l`

result 8 July: 520
result 18 July: 522

A third kind of relationship is the references relationship. Some descriptions reference an accession records. Links to these accession Records even if they are not online are suitable to appear in the references section.

### Dates

The namespace dcterms, upon which OLAC is built, has a variety of date options wihin it. Dates in heritily infer an event and the type of date within dcterms imputs a semantics upon that event. Those dates relevent to the provenance discussion are: dct:created, dct:modified, dct:dateAccepted, and dct:dateSubmitted.


### accrualMethod

Since reciving is a provenance action then there is a reasonable expectation there should be something in the provenance record when `accrualMethod` is used.


`grep -n -i 'accession' ListRecords-20210708.xml`


`grep -n -i -C 0 '/dcterms:provenance' ListRecords-20210708.xml | wc -l`

2924

` grep -n -i -C 0 'dcterms:source' ListRecords-20210708.xml | wc -l`

result 8 July: 0
result 18 July: 0

`grep -n -i -C 0 'dc:source' ListRecords-20210708.xml | wc -l`

result 8 July: 6023
result 18 July: 6023

`grep -n -i -C 0 'replacedby' ListRecords-20210708.xml | wc -l`

result 8 July: 2323
result 18 July: 2329

`grep -n -i -C 0 'replaces' ListRecords-20210708.xml | wc -l`

result 8 July: 6521
result 18 July: 6521

### Roles

Get a list of the differnt roles used in the data set:

`grep -n -i -C 0 'olac:role' ListRecords-20210718.xml > OLAC-roles.txt`

`cat OLAC-roles.txt | sort -u | cut -d " " -f 2 | sort | uniq -c > OLAC-role-distribution.txt`

This might be self selecting to only OLAC roles. Another query may try to use only the contributor element.

there seemed to be 17 malformed role lines

Due to the way roles are applied there needs to be an OLAC Role Application Recomendation so that roles are clearly appled consistently.

<hr>

## Residue Questions

I wonder how many of these records were created or harvested prior to 2004 when provenance became an element.

If provenace and no dcmi type count
If provenance and if one dcmitype, count for each different dcmi type
If provenance and more than one dcmityp in record, count records
If provenance and more than one format in record, count records

how do I do two lines: (a join statement) and how do I do get the values of the content?
			<dc:type xsi:type="dcterms:DCMIType">Text</dc:type>

I want to know if the item with provenance are collections, undeclared, plurals, or items (and which items).
