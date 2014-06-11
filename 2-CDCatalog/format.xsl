<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes"/>

<xsl:param name="year" />
<xsl:param name="artist"/>

<!-- Варианты: artist*, album, year, label -->
<xsl:param name="sortparam" select="'artist'"/>

<!-- Варианты: ascending*, descending -->
<xsl:param name="order" select="'ascending'"/>

<xsl:variable 
  name="disk_selector"
  select="/disks/disk[(not($year) or year/text()=$year) and (not($artist) or artist/text()=$artist)]"
/>

<xsl:template match="/">
  <html>
  <body>
    <div class="disks">
      <xsl:apply-templates select="$disk_selector">
        <xsl:sort data-type="text" order="{$order}" select="*[name()=$sortparam]" />
      </xsl:apply-templates>
    </div>
  </body>
  </html>
</xsl:template>

<xsl:template match="disk">
  <div class="disk">
    <h3 class="disk-album-value"><xsl:value-of select="album"/></h3>
    <div class="disk-cover">
      <img class="disk-cover-image">
        <xsl:attribute name="src">
          <xsl:value-of select="cover/@url"/>
       </xsl:attribute>
      </img>
    </div>
    <div class="disk-label">
      <span class="disk-label-label">Студия: </span>
      <span class="disk-label-value">
        <xsl:value-of select="label"/>
      </span>
    </div>

    <div class="disk-artist">
      <span class="disk-artist-label">Автор: </span>
      <span class="disk-artist-value">
        <xsl:value-of select="artist"/>
      </span>
    </div>

    <div class="disk-year">
      <span class="disk-year-label">Год: </span>
      <span class="disk-year-value">
        <xsl:value-of select="year"/>
      </span>
    </div>

    <div class="disk-tracks">
      <h4 class="disk-tracks-label">Треки:</h4>
      <ul class="disk-tracks-list">
        <xsl:apply-templates select="tracks/track"/>
      </ul>
    </div>
  </div>
</xsl:template>

<xsl:template match="track">
  <li class="disk-tracks-list-item">
    <xsl:value-of select="."/>
  </li>
</xsl:template>

</xsl:stylesheet>

