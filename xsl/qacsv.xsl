<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="xsl fo xs fn">
<xsl:output method="text" indent="no"/>
<xsl:template match="/">Topic Title|File Path|Violation|Type|Severity|Assigned To|Action Taken|False Positive
<xsl:for-each select="/topic/body/section[contains(@class, 'topicReport')]"><xsl:for-each select="data/descendant-or-self::*[contains(@type, 'msg')][not(contains(@class, 'step'))][not(contains(@class, 'xrefs'))]">
<xsl:value-of select="preceding::data[contains(@name, 'topicTitle')][1]/normalize-space(replace(.,',',';'))"/>|<xsl:value-of select="substring-after(preceding::data[contains(@name, 'filePath')][1], 'temp_in\')"/>|<xsl:value-of select="replace(., ',',';')"/>|<xsl:value-of select="replace(@class,',',';')"/>|<xsl:value-of select="@importance"/><xsl:text>
</xsl:text></xsl:for-each></xsl:for-each>
</xsl:template>
</xsl:stylesheet>
