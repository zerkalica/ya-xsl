<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes"/>

<xsl:param name="year" />
<xsl:param name="artist"/>

<!-- Варианты: artist*, album, year, studio -->
<xsl:param name="sortparam" select="'artist'"/>

<!-- Варианты: ascending*, descending -->
<xsl:param name="order" select="'ascending'"/>

<xsl:template match="/">
  <html>
  <body>
    <xsl:apply-templates select="/discs/album[(not($year) or @year=$year) and (not($artist) or @artist=$artist)]">
      <xsl:sort data-type="text" order="{$order}" select="*[name()=$sortparam]" />
    </xsl:apply-templates>
  </body>
  </html>
</xsl:template>

<xsl:template match="/discs/album">
  <div>
    <div>
      <span>Студия: </span>
      <span>
        <xsl:value-of select="@studio"/>
      </span>
    </div>

    <div>
      <span>Автор: </span>
      <span>
        <xsl:value-of select="@artist"/>
      </span>
    </div>

    <div>
      <span>Год: </span>
      <span>
        <xsl:value-of select="@year"/>
      </span>
    </div>

    <div>
      <h3>Треки:</h3>
      <ul>
        <li>
          <xsl:value-of select="track"/>
        </li>
      </ul>
    </div>
  </div>
</xsl:template>

</xsl:stylesheet>

