<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
  <xsl:output indent="yes" method="xml" />
  <xsl:template match="/">
    <xsl:variable name="excludes">
      <xsl:for-each select="distinct-values(//sl[@id = 'excludes']/sli)">
        <xsl:sort order="ascending" select="normalize-space(.)" />
        <xsl:value-of select="concat('parent::', (normalize-space(.)))" />
        <xsl:if test="position() &lt; last()">
          <xsl:text> or </xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:element name="xsl:stylesheet">
      <xsl:attribute name="version">2.0</xsl:attribute>
      <xsl:element name="xsl:template">
        <xsl:attribute name="name">term</xsl:attribute>
        <xsl:apply-templates
          select="descendant::*[contains(@class, ' reference/properties ')]/*[contains(@class, ' reference/property ')][descendant::*[contains(@class, ' reference/propvalue ')]]">
          <xsl:with-param name="excludes">
            <xsl:value-of select="$excludes" />
          </xsl:with-param>
        </xsl:apply-templates>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- XPath expressions -->
  <xsl:template match="*[contains(@class, ' reference/property ')]">
    <xsl:param name="excludes" required="no" />
    <xsl:element name="xsl:if">
      <xsl:attribute name="test">
        <xsl:choose>
          <xsl:when
            test="*[contains(@class, ' reference/propvalue ')][descendant::*[contains(@class, ' pr-d/codeph ')]]">
            <!-- It is an XPath expression -->
            <xsl:value-of
              select="replace(normalize-space(*[contains(@class, ' reference/propvalue ')]), '\$excludes', concat('not(', $excludes, ')'))"
             />
          </xsl:when>
          <xsl:otherwise>
            <!-- Assume it is a terminology check -->
            <xsl:text>.//*/text()</xsl:text>
            <xsl:if test="$excludes">
              <xsl:value-of select="concat('[not(', $excludes, ')]')" />
            </xsl:if>
            <xsl:text>[matches(.,'</xsl:text>
            <xsl:value-of select="*[contains(@class, ' reference/propvalue ')]" />
            <xsl:text>', 'i')]</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>

      <xsl:element name="data">
        <xsl:attribute name="type">msg</xsl:attribute>
        <xsl:attribute name="outputclass">
          <xsl:value-of select="replace(ancestor::properties/@id, '_', ' ')" />
        </xsl:attribute>
        <xsl:attribute name="importance">
          <xsl:value-of select="lower-case(*[contains(@class, ' reference/proptype ')])" />
        </xsl:attribute>
        <xsl:value-of select="*[contains(@class, ' reference/propdesc ')]" />
      </xsl:element>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
