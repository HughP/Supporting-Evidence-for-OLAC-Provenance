<?xml version="1.0" encoding="UTF-8"?>
<!--<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1" >-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1" xmlns="http://www.openarchives.org/OAI/2.0/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dc="http://purl.org/dc/elements/1.1/">
    <xsl:output method="text" encoding="UTF-8" indent="no"/>

    <xsl:template match="/">
        <xsl:text>Number of records = </xsl:text>
        <xsl:value-of select="count(descendant-or-self::*[name()='record'])"/>
        <xsl:text>&#xa;Number of dcterms:provenance = </xsl:text>
        <xsl:value-of select="count(descendant-or-self::dcterms:provenance)"/>
        <xsl:text>&#xa;Instances of 'P/provenance in text = </xsl:text>
        <xsl:variable name="provenance" select="descendant::text()[contains(.,'provenance')]"/>
        <xsl:variable name="Provenance" select="descendant::text()[contains(.,'Provenance')]"/>
        <xsl:value-of select="count($provenance) + count($Provenance)"/>
        <xsl:text>&#xa;Number of records containing at least one dcterms:provenance = </xsl:text>
        <xsl:value-of select="count(descendant-or-self::*[name()='record'][descendant-or-self::dcterms:provenance])"/>
        <xsl:text>&#xa;Number of records with a dc:description also containing at least one dcterms:provenance = </xsl:text>
        <xsl:value-of select="count(descendant-or-self::*[name()='record'][descendant-or-self::dc:description][descendant-or-self::dcterms:provenance])"/>
        <xsl:text>&#xa;Number of dc:description = </xsl:text>
        <xsl:value-of select="count(descendant-or-self::dc:description)"/>
        <xsl:text>&#xa;Number of records containing at least one dc:description = </xsl:text>
        <xsl:value-of select="count(descendant-or-self::*[name()='record'][descendant-or-self::dc:description])"/>
        <xsl:text>&#xa;Number of data providers = </xsl:text>
        <xsl:variable name="iDataProviders" select="descendant-or-self::*[name()='identifier']"/>
        <xsl:value-of select="count($iDataProviders)"/>
        <xsl:text>&#xa;Number of data providers using dc:description = </xsl:text>
        <xsl:variable name="iDataProvidersWithDescription" select="descendant-or-self::*[name()='identifier'][../../descendant-or-self::dc:description]"/>
        <xsl:value-of select="count($iDataProvidersWithDescription)"/>
        <xsl:text>&#xa;Number of data providers less data providers using dc:description = </xsl:text>
        <xsl:value-of select="count($iDataProviders) - count($iDataProvidersWithDescription)"/>        
        <xsl:text>&#xa;Number of data providers using dcterms:provenance = </xsl:text>
        <xsl:value-of select="count(descendant-or-self::*[name()='identifier'][../../descendant-or-self::dcterms:provenance])"/>
    </xsl:template>
</xsl:stylesheet>
