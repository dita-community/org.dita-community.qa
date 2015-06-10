<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
  exclude-result-prefixes="ditaarch xsl fo xs fn">
  <xsl:output method="xml" indent="yes" />

  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes"><![CDATA[
<!DOCTYPE map PUBLIC "-//OASIS//DTD DITA Map//EN" "map.dtd">
]]></xsl:text>
    <map>
      <title><xsl:value-of
          select="/topic/body/section[@id='overalld2']/data[@name='docTitle']"
         /> Violations</title>
      <topicmeta>
        <xsl:copy-of select="/topic/body/section[@id='overalld2']/*" copy-namespaces="no"/>
      </topicmeta>
      <xsl:for-each
        select="/topic/body/section[contains(@class, 'topicReport')][descendant-or-self::*[contains(@type, 'msg')]]">
        <topicref>
          <xsl:attribute name="href">
            <xsl:value-of
              select="replace(replace(substring-after(data[contains(@name, 'filePath')][1], 'C:'), '\\', '/'), ' ', '%20')"
             />
          </xsl:attribute>
          <topicmeta>
            <xsl:for-each
              select="data/descendant-or-self::*[contains(@type, 'msg')][not(contains(@class, 'step'))][not(contains(@class, 'xrefs'))]">
              <category>
                <keyword>QA violation:</keyword>
                <xsl:text> </xsl:text>
                <xsl:value-of select="." />
                <data>
                  <xsl:attribute name="name">importance</xsl:attribute>
                  <xsl:attribute name="value">
                    <xsl:value-of select="@importance" />
                  </xsl:attribute>
                </data>
                <data>
                  <xsl:attribute name="name">type</xsl:attribute>
                  <xsl:attribute name="value">
                    <xsl:value-of select="@class" />
                  </xsl:attribute>
                </data>
              </category>
            </xsl:for-each>
          </topicmeta>
        </topicref>
      </xsl:for-each>
    </map>
  </xsl:template>
</xsl:stylesheet>
