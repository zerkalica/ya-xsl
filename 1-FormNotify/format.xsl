<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes"/>
<xsl:param name="form_name" />

<xsl:template match="/">
  <html>
  <body>
    <xsl:apply-templates select="/forms/form[@id=$form_name]" />
  </body>
  </html>
</xsl:template>

<xsl:template match="/forms/form">
  <ul>
    <xsl:apply-templates select="notify" />
  </ul>
</xsl:template>

<xsl:template match="notify">
  <li>
    <h3><xsl:value-of select="@title"/></h3>
    <p>
      <xsl:value-of select="."/>
    </p>
  </li>
</xsl:template>

</xsl:stylesheet>

