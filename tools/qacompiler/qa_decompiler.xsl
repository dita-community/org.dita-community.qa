<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  version="2.0">
  <xsl:variable name="singleQuote">'</xsl:variable>
  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes"><![CDATA[
<!DOCTYPE reference PUBLIC "-//OASIS//DTD DITA Reference//EN" "reference.dtd">
]]></xsl:text>
    <reference id="reference_qaChecks">
      <title>QA Checks</title>
      <shortdesc>This file defines the checks that are run by the QA
        plugin.</shortdesc>
      <refbody>
        <xsl:apply-templates select="//xsl:template" />
      </refbody>
    </reference>
  </xsl:template>

  <xsl:template match="xsl:template[xsl:if]">
    <properties>
      <xsl:attribute name="id">
        <xsl:value-of select="@name" />
      </xsl:attribute>
      <prophead>
        <proptypehd>Severity</proptypehd>
        <propvaluehd>Expression ( <xsl:value-of select="@name" />) </propvaluehd>
        <propdeschd>Message</propdeschd>
      </prophead>
      <xsl:apply-templates />
    </properties>
  </xsl:template>

  <xsl:template
    match="xsl:if[matches(@test, './/*.*excludes.*(contains|matches).*')][not(contains(@test, 'not'))]">
    <!-- it's a string match -->
    <property>
      <proptype>
        <xsl:value-of select="data/@importance" />
      </proptype>
      <propvalue>
        <term>
          <xsl:variable name="thisTerm">
            <xsl:value-of select="tokenize(@test, $singleQuote)[last()-1]"/>
          </xsl:variable>
          <xsl:value-of select="replace($thisTerm, '([A-Z]|\[|\])', '')" />
        </term>
      </propvalue>
      <propdesc>
        <xsl:value-of select="data/text()" />
      </propdesc>
    </property>
  </xsl:template>

  <xsl:template match="xsl:if">
    <!-- it's an xpath  -->
    <property>
      <proptype>
        <xsl:value-of select="data/@importance" />
      </proptype>
      <propvalue>

        <codeph>
          <xsl:value-of select="replace(@test, '\s+', ' ')" />
        </codeph>
      </propvalue>
      <propdesc>
        <xsl:value-of select="data/text()" />
      </propdesc>
    </property>
  </xsl:template>
  <xsl:template match="*" />
</xsl:stylesheet>
