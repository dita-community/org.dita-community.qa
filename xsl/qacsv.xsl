<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="xsl fo xs fn">
<xsl:output method="text" indent="no"/><xsl:variable name="delim"><xsl:text>&#x09;</xsl:text></xsl:variable>
<xsl:template match="/">sep=<xsl:value-of select="$delim"/><xsl:text>&#xa;</xsl:text>Topic Title<xsl:value-of select="$delim"/>File Path<xsl:value-of select="$delim"/>Violation<xsl:value-of select="$delim"/>Type<xsl:value-of select="$delim"/>Severity<xsl:value-of select="$delim"/>Assigned To<xsl:value-of select="$delim"/>Action Taken<xsl:value-of select="$delim"/>False Positive
<xsl:for-each select="/topic/body/section[contains(@outputclass, 'topicReport')]"><xsl:for-each select="data/descendant-or-self::*[contains(@type, 'msg')][not(contains(@class, 'step'))][not(contains(@class, 'xrefs'))]">
  <xsl:value-of select="concat('=HYPERLINK(&quot;', preceding::data[contains(@name, 'filePath')][1], '&quot;,&quot;', preceding::data[contains(@name, 'topicTitle')][1]/normalize-space(replace(.,',',';')), ' [click to open]&quot;)')"/><xsl:value-of select="$delim"/><xsl:value-of select="preceding::data[contains(@name, 'filePath')][1]"/><xsl:value-of select="$delim"/><xsl:value-of select="replace(., ',',';')"/><xsl:value-of select="$delim"/><xsl:value-of select="replace(@class,',',';')"/><xsl:value-of select="$delim"/><xsl:value-of select="@importance"/><xsl:text>
</xsl:text></xsl:for-each></xsl:for-each>
</xsl:template>
</xsl:stylesheet>
