<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xf="http://www.w3.org/2002/xforms"
    xmlns:dyn="http://exslt.org/dynamic"
    xmlns:exsl="http://exslt.org/common"
    xmlns:my="http://example.com/myns"
    xmlns="http://example.com/myns"
>

<xsl:import href="variables.xsl"/>

<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

<xsl:template name="error-item">
  <xsl:param name="message"/>
  <error>
    <xsl:value-of select="$message"/>
  </error>
</xsl:template>

<xsl:template match="*" mode="error-element">
  <error-item>
    <xsl:value-of select="."/>
  </error-item>
</xsl:template>

<xsl:template name="errors-list">
  <xsl:param name="errors"/>
  <xsl:choose>
    <xsl:when test="normalize-space($errors)">
      <errors>
        <xsl:apply-templates select="exsl:node-set($errors)/*" mode="error-element" />
      </errors>
    </xsl:when>
    <xsl:otherwise>
      <text>
        <xsl:value-of select="$no_errors_message"/>
      </text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="/">
  <root>
    <xsl:call-template name="errors-list">
      <xsl:with-param name="errors">
        <xsl:apply-templates select="$form_model/xf:bind"/>
      </xsl:with-param>
    </xsl:call-template>
  </root>
</xsl:template>

<xsl:template match="xf:bind">
  <xsl:variable name="id" select="@id"/>
  <xsl:choose>
    <xsl:when test="(@required='true()' and not($form_data/*[name()=$id]/text()))">
      <xsl:call-template name="error-item">
        <xsl:with-param name="message" select="$form_view[@ref=$id]/xf:alert"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="normalize-space(@constraint)">
      <xsl:apply-templates select="$form_data/*[name()=$id]" mode="constraint-data">
        <xsl:with-param name="constraint" select="@constraint"/>
        <xsl:with-param name="message" select="$form_view[@ref=$id]/xf:alert"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="my:data/*" mode="constraint-data">
  <xsl:param name="message" />
  <xsl:param name="constraint" />
  <xsl:if test="not(dyn:evaluate($constraint))">
    <xsl:call-template name="error-item">
      <xsl:with-param name="message" select="$message" />
    </xsl:call-template>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
