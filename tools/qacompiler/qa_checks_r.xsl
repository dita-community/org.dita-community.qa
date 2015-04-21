<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:template name="qaChecks">
      <xsl:if test="b">
         <li class="warning">Do not use typographic markup b</li>
      </xsl:if>
      <xsl:if test="p[(not(text()) and not(node()))]">
         <li class="error">P element is empty</li>
      </xsl:if>
      <xsl:if test="descendant::*[not(codeblock or draft-comment or filepath or shortdesc or uicontrol or varname)]/text()[contains(.,'data center')]">
         <li class="warning">data center - Use "datacenter"</li>
      </xsl:if>
      <xsl:if test="descendant::*[not(codeblock or draft-comment or filepath or shortdesc or uicontrol or varname)]/text()[contains(.,'via')]">
         <li class="error">Avoid "via." Use "across," "along," "by," "from," "on,"
          "through," or "using" instead.</li>
      </xsl:if>
   </xsl:template>
</xsl:stylesheet>
