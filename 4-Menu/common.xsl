<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:my="http://example.com/myns"
>

<xsl:template match="my:menu">
  <ul class="menu">
    <xsl:attribute name="id">
      <xsl:value-of select="@id"/>
    </xsl:attribute>
    <xsl:apply-templates select="my:item"/>
  </ul>
</xsl:template>

<xsl:template match="my:item[@is-current]">
  <li class="menu-item-active">
    <span class="menu-link-active">
      <xsl:value-of select="my:title"/>
    </span>
  </li>
</xsl:template>

<xsl:template match="my:item[not(@is-current)]">
  <li class="menu-item-no_active">
    <a class="menu-link-no_active">
      <xsl:attribute name="href">
        <xsl:value-of select="my:url"/>
      </xsl:attribute>
      <xsl:value-of select="my:title"/>
    </a>
  </li>
</xsl:template>

</xsl:stylesheet>
