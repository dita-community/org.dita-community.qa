<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <xsl:variable name="excludes">codeblock or draft-comment or filepath or
    shortdesc or uicontrol or varname</xsl:variable>
   <xsl:template name="term">
      <xsl:if test="b">
         <data type="msg" ouputclass="markup" importance="warning">Do not use typographic markup b</data>
      </xsl:if>
      <xsl:if test="p[(not(text()) and not(node()))]">
         <data type="msg" ouputclass="markup" importance="error">P element is empty</data>
      </xsl:if>
      <xsl:if test="descendant::*[not(codeblock or draft-comment or filepath or shortdesc or uicontrol or varname)]/text()[matches(.,'data center', 'i')]">
         <data type="msg" ouputclass="term mmstp" importance="warning">data center - Use "datacenter"</data>
      </xsl:if>
      <xsl:if test="descendant::*[not(codeblock or draft-comment or filepath or shortdesc or uicontrol or varname)]/text()[matches(.,'via', 'i')]">
         <data type="msg" ouputclass="term mmstp" importance="error">Avoid "via." Use "across," "along," "by," "from," "on,"
          "through," or "using" instead.</data>
      </xsl:if>
   </xsl:template>
</xsl:stylesheet>