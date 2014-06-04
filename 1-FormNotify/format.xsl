<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes"/>
<xsl:param name="form_name" />

<xsl:template match="/">
  <html>
  <body>
    <form id="$form_name">
    </form>
    <xsl:apply-templates select="$form_name" />
  </body>
  </html>
</xsl:template>

<xsl:template match="/forms/form">
  <li>
    <h3><xsl:value-of select="notify/@title"/></h3>
    <p><xsl:value-of select="notify"/></p>
  </li>
</xsl:template>

</xsl:stylesheet>

<!-- http://htmlweb.ru/xml/xslt1.php -->

