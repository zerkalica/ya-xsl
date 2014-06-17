<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:my="http://example.com/myns"
>

<xsl:import href="common.xsl"/>

<xsl:param name="menu_id" select="'menu1'"/>

<xsl:variable name="menu" select="/my:menus/my:menu[@id=$menu_id]"/>

<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
  <html>
  <body>
    <xsl:apply-templates select="$menu"/>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>
