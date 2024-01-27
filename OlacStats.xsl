<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs" xmlns:oai="http://www.openarchives.org/OAI/2.0/"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    version="2.0">
    
    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>
    
    
    <xsl:template match="node()|@*">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="oai:ListRecords">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Record Count</title>
            </head>
            <body>
                <h1>Statistics</h1>
                <p>Raw count of 'record' elements: <xsl:value-of select="count(//oai:record)"/></p>
                <h3>Records by depositor</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                
                <xsl:variable name="groups">
                    <xsl:for-each-group select="//oai:record" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <group>
                            <xsl:copy-of select="current-group()"/>
                        </group>
                    </xsl:for-each-group>
                </xsl:variable>
                <h2>Total number of depositors</h2>
                <p><xsl:value-of select="count($groups/*:group)"/></p>
                <p>Raw count of 'dcterms:provenance': <xsl:value-of select="count(//dcterms:provenance)"/></p>
                <p>Records with dcterms:provenance: <xsl:value-of select="count(//oai:record[descendant::dcterms:provenance])"/></p>
                <p>Records with empty provenance: <xsl:value-of select="count(//oai:record[descendant::dc:provenance[not(text()) or normalize-space(text()) = '']])"/></p>
                <h3>Records by depositor with dcterms:provenance</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record[descendant::dcterms:provenance]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                <p>Raw count of 'dc:subject' statements: <xsl:value-of select="count(//dc:subject)"/></p>
                <p>Records with 'dc:subject': <xsl:value-of select="count(//oai:record[descendant::dc:subject])"/></p>
                <h3>Records by depositor with dc:subject</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record[descendant::dc:subject]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                <p>Raw count of 'dc:description' statements: <xsl:value-of select="count(//dc:description)"/></p>
                <p>Records with dc:description: <xsl:value-of select="count(//oai:record[descendant::dc:description])"/></p>
                <h3>Records by depositor with dc:description</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record[descendant::dc:description]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                
                
                
                <h2>All Text fields mentioning provenance</h2>
                <ul>
                    <xsl:for-each-group select="//dc:*[contains(lower-case(./text()), 'provenance')]" group-by="local-name()">
                        <li>dc:<xsl:value-of select="current-grouping-key()"/> : <xsl:value-of select="count(current-group())"/></li>
                    </xsl:for-each-group>
                    <xsl:for-each-group select="//dcterms:*[contains(lower-case(./text()), 'provenance')]" group-by="local-name()">
                        <li>dcterms:<xsl:value-of select="current-grouping-key()"/> : <xsl:value-of select="count(current-group())"/></li>
                    </xsl:for-each-group>
                </ul>
                <h1>Records with Provenance</h1>
                <h2>Count of records with dcterms:provenance or dc:subject mentioning provenance or dc:description mentioning provenance</h2>
                <p>
                    <xsl:value-of select="count(//oai:record[descendant::dcterms:provenance or descendant::dc:subject[contains(lower-case(./text()), 'provenance')] or descendant::dc:description[contains(lower-case(./text()), 'provenance')]])" />
                </p>
                <h3>Sorted by depositor:</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record[descendant::dcterms:provenance or descendant::dc:subject[contains(lower-case(./text()), 'provenance')] or descendant::dc:description[contains(lower-case(./text()), 'provenance')]]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                <h2>Raw Count of records with provenance or dc:subject mentioning provenance</h2>
                <p>
                    <xsl:value-of select="count(//oai:record[descendant::dcterms:provenance or descendant::dc:subject[contains(lower-case(./text()), 'provenance')]])" />
                </p>
                <h3>Sorted by depositor:</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record[descendant::dcterms:provenance or descendant::dc:subject[contains(lower-case(./text()), 'provenance')]]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                
                <h2>Raw Count of records with provenance AND dc:subject mentioning provenance</h2>
                <p>
                    <xsl:value-of select="count(//oai:record[descendant::dcterms:provenance and descendant::dc:subject[contains(lower-case(./text()), 'provenance')]])" />
                </p>
                <h3>Sorted by depositor:</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record[descendant::dcterms:provenance and descendant::dc:subject[contains(lower-case(./text()), 'provenance')]]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                <h2>Records with both dcterms:provenance and dc:description mentioning provenance</h2>
                <p><xsl:value-of select="count(//oai:record[descendant::dc:description[contains(lower-case(./text()), 'provenance')] and descendant::dcterms:provenance])"/></p>
                <ul>
                    <xsl:for-each-group select="//oai:record[descendant::dc:description[contains(lower-case(./text()), 'provenance')] and descendant::dcterms:provenance]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                <h2>Count of records with dcterms:provenance</h2>
                <p><xsl:value-of select="count(//oai:record/descendant::dcterms:provenance[1]/ancestor::oai:record)"/></p>
                <h3>Sorted by depositor</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record/descendant::dcterms:provenance[1]/ancestor::oai:record" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                
                
                <h1>Negative</h1>
                <h2>Count of records without provenance or dc:subject mentioning provenance</h2>
                <p>
                    <xsl:value-of select="count(//oai:record[not(descendant::dcterms:provenance) and not(descendant::dc:subject[contains(lower-case(./text()), 'provenance')])])" />
                    <br/>Example: <xsl:value-of select="//oai:record[not(descendant::dcterms:provenance) and not(descendant::dc:subject[contains(lower-case(./text()), 'provenance')])][1]/descendant::oai:identifier/text()"/>
                </p>
                <h3>Sorted by depositor</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record[not(descendant::dcterms:provenance) and not(descendant::dc:subject[contains(lower-case(./text()), 'provenance')])]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>dc:<xsl:value-of select="current-grouping-key()"/> : <xsl:value-of select="count(current-group())"/></li>
                    </xsl:for-each-group>
                </ul>
                <h2>Count of records without dcterms:provenance</h2>
                <p>
                    <xsl:value-of select="count(//oai:record[not(descendant::dcterms:provenance[1])])"/>
                </p>
                <h3>Sorted by depositor</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record[not(descendant::dcterms:provenance[1])]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                <h2>Count of records without dc:subject of provenance</h2>
                <p>
                    <xsl:value-of select="count(//oai:record[not(descendant::dc:subject[contains(lower-case(./text()), 'provenance')])])" />
                </p>
                <h3>Sorted by depositor</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record[not(descendant::dc:subject[contains(lower-case(./text()), 'provenance')])]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                <h2>Count of records without dc:description of provenance</h2>
                <p>
                    <xsl:value-of select="count(//oai:record[not(descendant::dc:description[contains(lower-case(./text()), 'provenance')])])" />
                </p>
                <h3>Sorted by depositor</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record[not(descendant::dc:description[contains(lower-case(./text()), 'provenance')])]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                <h1>Count of records with more than 1 dcterms:provenance</h1>
                <p><xsl:value-of select="count(//oai:record[descendant::dcterms:provenance[2]])"/></p>
                <h3>Sorted by depositor</h3>
                <ul>
                    <xsl:for-each-group select="//oai:record[descendant::dcterms:provenance[2]]" group-by="tokenize(./oai:header/oai:identifier, ':')[2]">
                        <li>
                            <xsl:value-of select="current-grouping-key()"/>: <xsl:value-of select="count(current-group())"/>
                            <br/>Example: <xsl:value-of select="current-group()[1]/descendant::oai:identifier/text()"/>
                        </li>
                    </xsl:for-each-group>
                </ul>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    
    <!-- <xsl:template name="count-provenance">
        <h2>Provenance Count Report</h2>
        <xsl:for-each select="//dc:*[contains(lower-case(./text()), 'prov')]">
            <xsl:sort select="local-name()"/>
            <xsl:variable name="elementName" select="local-name()"/>
            <xsl:variable name="count" select="count(//dc:*[local-name() = $elementName][contains(lower-case(./text()), 'prov')])"/>
            <xsl:if test="not(./preceding-sibling::dc:*[local-name() = $elementName])">
                <p><xsl:value-of select="$elementName"/> : <xsl:value-of select="$count"/></p>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>-->
    
</xsl:stylesheet>

