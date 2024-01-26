<?xml version="1.0" encoding="UTF-8"?>
<!--<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1" >-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1" xmlns="http://www.openarchives.org/OAI/2.0/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dc="http://purl.org/dc/elements/1.1/">
    <xsl:output method="text" encoding="UTF-8" indent="no"/>

    <xsl:template match="/">
        <xsl:text>OAI-ID,dc:description,dcterms:provenance,other tag&#xa;</xsl:text>
        <xsl:for-each select="descendant-or-self::*[name()='record']">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="descendant::*[name()='identifier']"/>
            <xsl:text>","</xsl:text>
            <xsl:value-of select="descendant::dc:description[1]"/>
            <xsl:text>","</xsl:text>
            <xsl:value-of select="descendant::dcterms:provenance[1]"/>
            <xsl:text>","</xsl:text>
            <!-- I don't understand what you want here... -->
            <xsl:text>"&#xa;</xsl:text>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
