<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:my="http://example.com/myns"
    xmlns:exsl="http://exslt.org/common"
>

<xsl:import href="common.xsl"/>

<xsl:variable name="project" select="/my:root/my:project"/>
<xsl:variable name="request_url" select="/my:root/my:request/my:url"/>
<xsl:variable name="request_host" select="/my:root/my:request/my:host"/>
<xsl:variable name="schema" select="'http'"/>
<xsl:variable name="schema_separator" select="'://'"/>

<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
  <html>
  <body>
    <xsl:variable name="menu">
      <xsl:apply-templates select="$project"/>
    </xsl:variable>
    <xsl:apply-templates select="exsl:node-set($menu)/node()"/>
  </body>
  </html>
</xsl:template>

<xsl:template match="my:project">
  <my:menu>
    <xsl:attribute name="id">
      <xsl:choose>
        <xsl:when test="boolean(@id)">
          <xsl:value-of select="@id"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('menu-', generate-id())"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates match="my:page"/>
  </my:menu>
</xsl:template>

<xsl:template match="my:page">
  <my:item>
    <xsl:if test="text()=$request_url">
      <xsl:attribute name="is-current">
        <xsl:value-of select="'true()'" />
      </xsl:attribute>
    </xsl:if>
    <my:title>
      <xsl:value-of select="@name"/>
    </my:title>
    <my:url>
      <xsl:value-of select="concat($schema, $schema_separator, $request_host, text())"/>
    </my:url>
  </my:item>
</xsl:template>

</xsl:stylesheet>
