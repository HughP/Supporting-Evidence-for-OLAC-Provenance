<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:olac="http://www.language-archives.org/OLAC/1.0/" version="2.0">

    <xsl:output method="xml" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>


    <xsl:template match="node() | @*" mode="copy">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" mode="copy"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="node() | @*">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="oai:ListRecords">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Provenance Record Count</title>
                <style type="text/css">
                    table {
                    border-collapse: collapse;
                    }
                    
                    tr {
                    padding: 2px 5px;
                    margin: 2px 5px;
                    }
                    td {
                    margin: 2px 5px;
                    padding: 2px 5px;
                    border-color: black;
                    border-style: solid;
                    border-width: 1px;
                    }
                    th {
                    border-color: black;
                    border-style: solid;
                    border-width: 1px;
                    }
                    .tg {
                        border-collapse: collapse;
                        border-spacing: 0;
                    }
                    .tg td {
                        border-color: black;
                        border-style: solid;
                        border-width: 1px;
                        font-family: Arial, sans-serif;
                        font-size: 14px;
                        overflow: hidden;
                        padding: 10px 5px;
                        word-break: normal;
                    }
                    .tg th {
                        border-color: black;
                        border-style: solid;
                        border-width: 1px;
                        font-family: Arial, sans-serif;
                        font-size: 14px;
                        font-weight: normal;
                        overflow: hidden;
                        padding: 10px 5px;
                        word-break: normal;
                    }
                    .tg .tg-0pky {
                        border-color: inherit;
                        text-align: left;
                        vertical-align: top
                    }
                    .tg-sort-header::-moz-selection {
                        background: 0 0
                    }
                    .tg-sort-header::selection {
                        background: 0 0
                    }
                    .tg-sort-header {
                        cursor: pointer
                    }
                    .tg-sort-header:after {
                        content: '';
                        float: right;
                        margin-top: 7px;
                        border-width: 0 5px 5px;
                        border-style: solid;
                        border-color: #404040 transparent;
                        visibility: hidden
                    }
                    .tg-sort-header:hover:after {
                        visibility: visible
                    }
                    .tg-sort-asc:after,
                    .tg-sort-asc:hover:after,
                    .tg-sort-desc:after {
                        visibility: visible;
                        opacity: .4
                    }
                    .tg-sort-desc:after {
                        border-bottom: none;
                        border-width: 5px 5px 0
                    }
                    .nav {
                        width: 100%;
                        background-color: rgb(255, 251, 251);
                        overflow: auto;
                        height: auto;
                        top: 0;
                        position: fixed;
                    }
                    .links {
                        display: inline-block;
                        text-align: center;
                        padding: 14px;
                        text-decoration: none;
                        font-size: 17px;
                        border-radius: 5px;
                        color: black;
                    }
                    .links:hover {
                        background-color: rgba(129, 129, 129, 0.473);
                    }
                    .selected {
                        background-color: rgb(33, 126, 255);
                        color: rgb(255, 255, 255);
                    }
                    h1 {
                      margin: 3.1rem 0 0.2rem 0 ;
                      font-size: 2.2em;
                    }</style>
            </head>
            <body>

                <xsl:variable name="records">
                    <xsl:for-each select="./oai:record">
                        <!-- Apply templates to process the current record, including the custom template for oai:metadata -->
                        <xsl:copy>
                            <!-- Copy all attributes and child nodes of the record -->
                            <xsl:apply-templates select="@* | node()" mode="copy"/>
                            <!-- Add the new provider element -->
                            <provider>
                                <xsl:value-of select="tokenize(oai:header/oai:identifier, ':')[2]"/>
                            </provider>
                        </xsl:copy>
                    </xsl:for-each>
                </xsl:variable>
                <h1>OLAC Statistics</h1>
                <div class="nav">
                    <a class="links selected" href="#">Top</a>
                    <a class="links" href="#dp">Data Providers</a>
                    <a class="links" href="#dcpe">Provenance Element</a>
                    <a class="links" href="#dcse">Subject Element</a>
                    <a class="links" href="#dcde">Description Element</a>
                    <a class="links" href="#inverseCount">Negatives</a>
                    <a class="links" href="#dcce">Contributor Element</a>
                    <a class="links" href="#dates">Date Elements</a>
                    <a class="links" href="#dccreatore">Creator Element</a>
                    <a class="links" href="#dccrd">Depositor Role</a>
                </div>
                <h2>Example Attribute</h2>
                <p>Records wirh a dc:language with an olac:code of 'eng': <xsl:value-of select="count($records/oai:record[descendant::dc:language[1][attribute::*:code = 'eng']])"/></p>
                 <p>Records wirh a dc:contributor with an olac:code of 'sponsor': <xsl:value-of select="count($records/oai:record[descendant::dc:contributor[1][attribute::*:code = 'sponsor']])"/></p>
                 <p>Records wirh a dc:contributor with an olac:code of 'collector': <xsl:value-of select="count($records/oai:record[descendant::dc:contributor[1][attribute::*:code = 'collector']])"/></p>
                 <p>Records wirh a dc:contributor with an olac:code of 'compiler': <xsl:value-of select="count($records/oai:record[descendant::dc:contributor[1][attribute::*:code = 'compiler']])"/></p>
                 <p>Records wirh a dc:contributor with an olac:code of 'depositor': <xsl:value-of select="count($records/oai:record[descendant::dc:contributor[1][attribute::*:code = 'depositor']])"/></p>
                <h2>Record Counts</h2>
                <p>Raw count of 'record' elements: <xsl:value-of select="count($records/oai:record)"
                    /></p>
                <h2 id="dp">Data Providers</h2>
                <h3>Records by Data-Provider</h3>
                <table id="tg-THkt9" class="tg">
                    <thead>
                        <tr>
                            <td class="tg-0pky">Data Provider</td>
                            <td class="tg-0pky">Count</td>
                            <td class="tg-0pky">Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group select="$records/oai:record" group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>

                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>

                <xsl:variable name="groups">
                    <xsl:for-each-group select="$records/oai:record" group-by="./*:provider">
                        <xsl:element name="group">
                            <xsl:attribute name="key">
                                <xsl:value-of select="./*:provider"/>
                            </xsl:attribute>
                            <xsl:copy-of select="current-group()"/>
                        </xsl:element>
                    </xsl:for-each-group>
                </xsl:variable>
                <h2>Total number of Data-Providers</h2>
                <p>
                    <xsl:value-of select="count($groups/*:group)"/>
                </p>
                <h2 id="dcpe">Use of the dcterms:provenance element</h2>
                <p>Raw count of 'dcterms:provenance': <xsl:value-of
                        select="count(//dcterms:provenance)"/></p>
                <p>Records with dcterms:provenance: <xsl:value-of
                        select="count($records/oai:record[descendant::dcterms:provenance])"/></p>
                <p>Records with empty provenance: <xsl:value-of
                        select="count($records/oai:record[descendant::dcterms:provenance[not(text()) or normalize-space(text()) = '']])"
                    /></p>

<h3 id="dccrd"> Records by depositor role</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>

                        <xsl:for-each-group select="$records/oai:record[descendant::dc:contributor[1][attribute::*:code = 'depositor']]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                
<h3> Records by contributor role</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>

                        <xsl:for-each-group select="$records/oai:record[descendant::dc:contributor[1]/text()]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>





                <h3>Records by Data-Provider with dcterms:provenance</h3>

                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>

                        <xsl:for-each-group select="$records/oai:record[descendant::dcterms:provenance]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2 id="dcse">Use of the dc:subject element</h2>
                <p>Raw count of 'dc:subject' statements: <xsl:value-of select="count(//dc:subject)"
                    /></p>
                <p>Records with 'dc:subject': <xsl:value-of
                        select="count($records/oai:record[descendant::dc:subject])"/></p>
                <h3>Records by Data-Provider with dc:subject</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group select="$records/oai:record[descendant::dc:subject]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <p>Records with 'dc:subject' mentioning provenance: <xsl:value-of
                    select="count($records/oai:record[descendant::dc:subject[contains(lower-case(./text()), 'provenance')]])"/></p>
                <h3>Records by Data-Provider with dc:subject mentioning provenance</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group select="$records/oai:record[descendant::dc:subject[contains(lower-case(./text()), 'provenance')]]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                            >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2 id="dcde">Use of the dc:description element</h2>
                <p>Raw count of 'dc:description' statements: <xsl:value-of
                        select="count(//dc:description)"/></p>
                <p>Records with dc:description: <xsl:value-of
                        select="count($records/oai:record[descendant::dc:description])"/></p>
                <h3>Records by Data-Provider with dc:description</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Records with dc:description</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group select="$records/oai:record[descendant::dc:description]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <p>Records with 'dc:description' mentioning provenance: <xsl:value-of
                    select="count($records/oai:record[descendant::dc:description[contains(lower-case(./text()), 'provenance')]])"/></p>
                <h3>Records by Data-Provider with dc:description mentioning provenance</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group select="$records/oai:record[descendant::dc:description[contains(lower-case(./text()), 'provenance')]]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                            >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2>All Text fields mentioning submit</h2>
                <ul>
                    <xsl:for-each-group select="//dc:*[contains(lower-case(./text()), 'submit')]"
                        group-by="local-name()">
                        <xsl:sort select="count(current-group())" data-type="number"
                            order="descending"/>
                        <li>dc:<xsl:value-of select="current-grouping-key()"/> : <xsl:value-of
                                select="count(current-group())"/></li>
                    </xsl:for-each-group>
                    <xsl:for-each-group
                        select="//dcterms:*[contains(lower-case(./text()), 'submit')]"
                        group-by="local-name()">
                        <xsl:sort select="count(current-group())" data-type="number"
                            order="descending"/>
                        <li>dcterms:<xsl:value-of select="current-grouping-key()"/> : <xsl:value-of
                                select="count(current-group())"/></li>
                    </xsl:for-each-group>
                </ul>
                <h2>All Text fields mentioning accession</h2>
                <ul>
                    <xsl:for-each-group select="//dc:*[contains(lower-case(./text()), 'accession')]"
                        group-by="local-name()">
                        <xsl:sort select="count(current-group())" data-type="number"
                            order="descending"/>
                        <li>dc:<xsl:value-of select="current-grouping-key()"/> : <xsl:value-of
                                select="count(current-group())"/></li>
                    </xsl:for-each-group>
                    <xsl:for-each-group
                        select="//dcterms:*[contains(lower-case(./text()), 'accession')]"
                        group-by="local-name()">
                        <xsl:sort select="count(current-group())" data-type="number"
                            order="descending"/>
                        <li>dcterms:<xsl:value-of select="current-grouping-key()"/> : <xsl:value-of
                                select="count(current-group())"/></li>
                    </xsl:for-each-group>
                </ul>
                <h2>All Text fields mentioning provenance</h2>
                <ul>
                    <xsl:for-each-group
                        select="//dc:*[contains(lower-case(./text()), 'provenance')]"
                        group-by="local-name()">
                        <xsl:sort select="count(current-group())" data-type="number"
                            order="descending"/>
                        <li>dc:<xsl:value-of select="current-grouping-key()"/> : <xsl:value-of
                                select="count(current-group())"/></li>
                    </xsl:for-each-group>
                    <xsl:for-each-group
                        select="//dcterms:*[contains(lower-case(./text()), 'provenance')]"
                        group-by="local-name()">
                        <xsl:sort select="count(current-group())" data-type="number"
                            order="descending"/>
                        <li>dcterms:<xsl:value-of select="current-grouping-key()"/> : <xsl:value-of
                                select="count(current-group())"/></li>
                    </xsl:for-each-group>
                </ul>
                <h1>Records with Provenance</h1>
                <h2>Count of records with dcterms:provenance or dc:subject mentioning provenance or
                    dc:description mentioning provenance</h2>
                <p>
                    <xsl:value-of
                        select="count($records/oai:record[descendant::dcterms:provenance or descendant::dc:subject[contains(lower-case(./text()), 'provenance')] or descendant::dc:description[contains(lower-case(./text()), 'provenance')]])"
                    />
                </p>
                <h3>Sorted by Data-Provider :</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[descendant::dcterms:provenance or descendant::dc:subject[contains(lower-case(./text()), 'provenance')] or descendant::dc:description[contains(lower-case(./text()), 'provenance')]]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2>Raw Count of records with provenance or dc:subject mentioning provenance</h2>
                <p>
                    <xsl:value-of
                        select="count($records/oai:record[descendant::dcterms:provenance or descendant::dc:subject[contains(lower-case(./text()), 'provenance')]])"
                    />
                </p>
                <h3>Sorted by Data-Provider :</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[descendant::dcterms:provenance or descendant::dc:subject[contains(lower-case(./text()), 'provenance')]]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>

                <h2>Raw Count of records with provenance AND dc:subject mentioning provenance</h2>
                <p>
                    <xsl:value-of
                        select="count($records/oai:record[descendant::dcterms:provenance and descendant::dc:subject[contains(lower-case(./text()), 'provenance')]])"
                    />
                </p>
                <h3>Sorted by Data-Provider :</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[descendant::dcterms:provenance and descendant::dc:subject[contains(lower-case(./text()), 'provenance')]]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2>Records with both dcterms:provenance and dc:description mentioning
                    provenance</h2>
                <p>
                    <xsl:value-of
                        select="count($records/oai:record[descendant::dc:description[contains(lower-case(./text()), 'provenance')] and descendant::dcterms:provenance])"
                    />
                </p>
                <h3>Sorted by Data-Provider </h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[descendant::dc:description[contains(lower-case(./text()), 'provenance')] and descendant::dcterms:provenance]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2>Count of records with dcterms:provenance</h2>
                <p>
                    <xsl:value-of
                        select="count($records/oai:record[descendant::dcterms:provenance[1]])"
                    />
                </p>
                <h3>Sorted by Data-Provider </h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[descendant::dcterms:provenance[1]]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h1 id="inverseCount">Negative</h1>
                <h2>Count of records without provenance or dc:subject mentioning provenance</h2>
                <p>
                    <xsl:value-of
                        select="count($records/oai:record[not(descendant::dcterms:provenance) and not(descendant::dc:subject[contains(lower-case(./text()), 'provenance')])])"/>
                    <br/>Example: <xsl:value-of
                        select="$records/oai:record[not(descendant::dcterms:provenance) and not(descendant::dc:subject[contains(lower-case(./text()), 'provenance')])][1]/descendant::oai:identifier/text()"
                    />
                </p>
                <h3>Sorted by Data-Provider </h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[not(descendant::dcterms:provenance) and not(descendant::dc:subject[contains(lower-case(./text()), 'provenance')])]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2>Count of records without dcterms:provenance</h2>
                <p>
                    <xsl:value-of
                        select="count($records/oai:record[not(descendant::dcterms:provenance[1])])"
                    />
                </p>
                <h3>Sorted by Data-Provider </h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[not(descendant::dcterms:provenance[1])]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2>Count of records without dc:subject of provenance (Other Subjects)</h2>
                <p>
                    <xsl:value-of
                        select="count($records/oai:record[not(descendant::dc:subject[contains(lower-case(./text()), 'provenance')])])"
                    />
                </p>
                <h3>Sorted by Data-Provider </h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[not(descendant::dc:subject[contains(lower-case(./text()), 'provenance')])]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2>Count of records without dc:description of provenance</h2>
                <p>
                    <xsl:value-of
                        select="count($records/oai:record[not(descendant::dc:description[contains(lower-case(./text()), 'provenance')])])"
                    />
                </p>
                <h3>Sorted by Data-Provider </h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[not(descendant::dc:description[contains(lower-case(./text()), 'provenance')])]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h1>Count of records with more than 1 dcterms:provenance</h1>
                <p>
                    <xsl:value-of
                        select="count($records/oai:record[descendant::dcterms:provenance[2]])"/>
                </p>
                <h3>Sorted by Data-Provider </h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Double Provenance Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[descendant::dcterms:provenance[2]]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2 id="dcce">Use of the dc:contributor element</h2>
                <p>Raw count of 'dc:contributor' statements: <xsl:value-of
                        select="count(//dc:contributor)"/></p>
                <p>Records with dc:contributor: <xsl:value-of
                        select="count($records/oai:record[descendant::dc:contributor])"/></p>
                <h3>Records by Data-Provider with dc:contributor</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Contributor Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group select="$records/oai:record[descendant::dc:contributor]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2 id="dcpube">Use of the dc:publisher element</h2>
                <p>Raw count of 'dc:publisher' statements: <xsl:value-of
                        select="count(//dc:publisher)"/></p>
                <p>Records with dc:publisher: <xsl:value-of
                        select="count($records/oai:record[descendant::dc:publisher])"/></p>
                <h3>Records by Data-Provider with dc:publisher</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Publisher Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group select="$records/oai:record[descendant::dc:publisher]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2 id="dccreatore">Use of the dc:creator element</h2>
                <p>Raw count of 'dc:creator' statements: <xsl:value-of select="count(//dc:creator)"
                    /></p>
                <p>Records with dc:creator: <xsl:value-of
                        select="count($records/oai:record[descendant::dc:creator])"/></p>
                <h3>Records by Data-Provider with dc:creator</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Creator Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group select="$records/oai:record[descendant::dc:creator]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>

                <h2 id="dccreatore">Use of the dc:source element</h2>
                <p>Raw count of 'dc:source' statements: <xsl:value-of select="count(//dc:source)"
                    /></p>
                <p>Records with dc:source: <xsl:value-of
                        select="count($records/oai:record[descendant::dc:source])"/></p>
                <h3>Records by Data-Provider with dc:source</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Source Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group select="$records/oai:record[descendant::dc:source]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>

                <h1 id="dates">Dates</h1>
                <h2 id="dctmodified">Use of the dcterms:created element</h2>
                <p>Raw count of 'dcterms:created' statements: <xsl:value-of
                        select="count(//dcterms:created)"/></p>
                <p>Records with dcterms:created: <xsl:value-of
                        select="count($records/oai:record[descendant::dcterms:created])"/></p>
                <h3>Records by Data-Provider with dcterms:created</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Created Date Element Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[descendant::dcterms:created]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2 id="dctmodified">Use of the dcterms:modified element</h2>
                <p>Raw count of 'dcterms:modified' statements: <xsl:value-of
                        select="count(//dcterms:modified)"/></p>
                <p>Records with dcterms:modified: <xsl:value-of
                        select="count($records/oai:record[descendant::dcterms:modified])"/></p>
                <h3>Records by Data-Provider with dcterms:modified</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>Modified Date Element Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[descendant::dcterms:modified]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2 id="dctsubmitted">Use of the dcterms:dateSubmitted element</h2>
                <p>Raw count of 'dcterms:dateSubmitted' statements: <xsl:value-of
                        select="count(//dcterms:dateSubmitted)"/></p>
                <p>Records with dcterms:dateSubmitted: <xsl:value-of
                        select="count($records/oai:record[descendant::dcterms:dateSubmitted])"/></p>
                <h3>Records by Data-Provider with dcterms:dateSubmitted</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>dateSubmitted Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[descendant::dcterms:dateSubmitted]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td class="tg-0pky">
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td class="tg-0pky">
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <h2 id="dctaccepted">Use of the dcterms:dateAccepted element</h2>
                <p>Raw count of 'dcterms:dateAccepted' statements: <xsl:value-of
                        select="count(//dcterms:dateAccepted)"/></p>
                <p>Records with dcterms:dateAccepted: <xsl:value-of
                        select="count($records/oai:record[descendant::dcterms:dateAccepted])"/></p>
                <h3>Records by Data-Provider with dcterms:dateAccepted</h3>
                <table>
                    <thead>
                        <tr>
                            <td>Data Provider</td>
                            <td>dateSubmitted Count</td>
                            <td>Example Record ID</td>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each-group
                            select="$records/oai:record[descendant::dcterms:dateAccepted]"
                            group-by="./*:provider">
                            <xsl:sort select="count(current-group())" data-type="number"
                                order="descending"/>
                            <tr>
                                <td>
                                    <xsl:value-of select="current-grouping-key()"/>
                                </td>
                                <td >
                                    <xsl:value-of select="count(current-group())"/>
                                </td>
                                <td>
                                    <xsl:element name="a">
                                        <xsl:attribute name="href"
                                                >http://www.language-archives.org/item/<xsl:value-of
                                                select="current-group()[1]/descendant::oai:identifier/text()"
                                            /></xsl:attribute>
                                        <xsl:value-of
                                            select="current-group()[1]/descendant::oai:identifier/text()"
                                        />
                                    </xsl:element>
                                </td>
                            </tr>
                        </xsl:for-each-group>
                    </tbody>
                </table>
                <xsl:apply-templates/>
                
            </body>
        </html>
    </xsl:template>


</xsl:stylesheet>
