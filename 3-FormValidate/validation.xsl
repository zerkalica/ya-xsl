<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xf="http://www.w3.org/2002/xforms"
    xmlns:my="http://example.com/myns"
>

<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:variable name="form_view" select="/html:html/html:body/my:form/*"/>
<xsl:variable name="form_model" select="/html:html/html:head/xf:model"/>
<xsl:variable name="form_data" select="$form_model/xf:instance/data"/>

<xsl:template match="/">
  <html>
  <body>
    <xsl:apply-templates select="$form_model/xf:bind"/>
  </body>
  </html>
</xsl:template>

<xsl:template match="xf:bind">
  <xsl:variable name="ref" select="@id"/>
  <xsl:if test="(@required='true()' and not($form_data[name()=$ref]))">
    <xsl:value-of select="$ref"/>:
    <xsl:value-of select="$form_view[@ref=$ref]/xf:alert"/>
  </xsl:if>
</xsl:template>


</xsl:stylesheet>
