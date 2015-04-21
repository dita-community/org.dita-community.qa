<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  version="2.0">
  <xsl:output indent="yes" method="xml" />
  <xsl:variable name="excludes">codeblock or draft-comment or filepath or
    shortdesc or uicontrol or varname</xsl:variable>
  <xsl:template match="/">
    <xsl:element name="xsl:stylesheet">
      <xsl:element name="xsl:template">
        <xsl:attribute name="name">qaChecks</xsl:attribute>
        <xsl:apply-templates
          select="descendant::*[contains(@class, ' reference/properties ')]/*[contains(@class, ' reference/property ')]"
         />
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- XPath expressions -->
  <xsl:template match="*[contains(@class, ' reference/property ')]">
    <xsl:element name="xsl:if">
      <xsl:attribute name="test">
        <xsl:choose>
          <xsl:when
            test="*[contains(@class, ' reference/propvalue ')][descendant::*[contains(@class, ' pr-d/codeph ')]]">
            <!-- It is an XPath expression -->
            <xsl:value-of select="*[contains(@class, ' reference/propvalue ')]"
             />
          </xsl:when>
          <xsl:otherwise>
            <!-- Assume it is a terminology check -->
            <xsl:text>descendant::*[not(</xsl:text>
            <xsl:value-of select="replace($excludes, '\s+', ' ')" />
            <xsl:text>)]/text()[contains(.,'</xsl:text>
            <xsl:value-of select="*[contains(@class, ' reference/propvalue ')]" />
            <xsl:text>')]</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <xsl:element name="li">
        <xsl:attribute name="class">
          <xsl:value-of
            select="lower-case(*[contains(@class, ' reference/proptype ')])" />
        </xsl:attribute>
        <xsl:value-of select="*[contains(@class, ' reference/propdesc ')]" />
      </xsl:element>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
