<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xf="http://www.w3.org/2002/xforms"
    xmlns:my="http://example.com/myns"
>

<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:variable name="form_model" select="/html:html/html:head/xf:model"/>

<xsl:template match="/">
  <html>
  <body>
    <xsl:apply-templates name="element_meta" select="$form_model/xf:bind"/>
  </body>
  </html>
</xsl:template>

<xsl:template match="xf:bind">
  erew
</xsl:template>


</xsl:stylesheet>
