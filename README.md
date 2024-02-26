# Supporting Evidence for OLAC Provenance
This repository contains the data and the methods for querying the data related to the OLAC Provenance paper.

## Record sourcing
Illustrative records for the paper can be found at `OLAC-Example-Records/`. There are four records. Three are from the 18 July 2021 data set, the other is from the 10/11 August 2011 data set (https://doi.org/10.5281/zenodo.7223348). Records contain the date of their last harvest in thier names and internally in the XML.

## Usage
Initial exploration of the data was done using the 8 July 2021 dataset. Publication version used the 18 July 2021 data set. (https://zenodo.org/records/5112131)

I had to update my GB allocation to RAM by using:
`export _JAVA_OPTIONS="-Xmx12g"`
and then to check it `java -XshowSettings:vm `
and then to generate the stats: `saxonb-xslt -xsl:OlacStats.xsl -s:ListRecords-20210718.xml -o:prov-stats.xhtml `

# Research Questions

The basic approach and research questions can be seen in the document `Research-Questions.md`

Credits: And Back's work can be seen on a different branch. Matt Lee's work is on the main branch and is most of the XSLT.

