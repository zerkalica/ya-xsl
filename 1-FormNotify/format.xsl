<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:param name="form_name" />

<xsl:variable name="form_selector" select="/forms/form"/>

<xsl:template match="/">
  <html>
  <body>
    <xsl:apply-templates select="$form_selector[@id=$form_name]" />
  </body>
  </html>
</xsl:template>

<xsl:template match="form">
  <ul class="notify-list">
    <xsl:apply-templates select="notify" />
  </ul>
</xsl:template>

<xsl:template match="notify">
  <li class="notify">
    <h3 class="notify-title"><xsl:value-of select="title"/></h3>
    <div class="notify-body">
      <xsl:apply-templates select="section" />
    </div>
  </li>
</xsl:template>

<xsl:template match="section">
  <section class="notify-body-section">
    <xsl:value-of select="text()"/>
    <xsl:apply-templates select="*[starts-with(name(), 'para')]" />
  </section>
</xsl:template>

<xsl:template match="para1">
  <p class="notify-body-section-para1">
    <xsl:value-of select="." />
  </p>
</xsl:template>

<xsl:template match="para2">
  <p class="notify-body-section-para2">
    <xsl:value-of select="." />
  </p>
</xsl:template>

<xsl:template match="para3">
  <p class="notify-body-section-para3">
    <xsl:value-of select="." />
  </p>
</xsl:template>

</xsl:stylesheet>
