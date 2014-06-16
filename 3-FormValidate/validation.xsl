<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xf="http://www.w3.org/2002/xforms"
    xmlns:my="http://example.com/myns"
    xmlns:dyn="http://exslt.org/dynamic"
    xmlns:exsl="http://exslt.org/common"
>

<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:variable name="form_view" select="/html:html/html:body/my:form/*"/>
<xsl:variable name="form_model" select="/html:html/html:head/xf:model"/>
<xsl:variable name="form_data" select="$form_model/xf:instance/data"/>
<xsl:variable name="no_errors_message">Нет ошибок</xsl:variable>

<xsl:template match="*" mode="error-element">
  <error-item>
    <xsl:value-of select="."/>
  </error-item>
</xsl:template>

<xsl:template name="errors-list">
  <xsl:param name="errors"/>
  <errors>
    <xsl:apply-templates select="exsl:node-set($errors)/*" mode="error-element" />
  </errors>
</xsl:template>

<xsl:template name="error-item">
  <xsl:param name="message"/>
  <error>
    <xsl:value-of select="$message"/>
  </error>
</xsl:template>

<xsl:template name="no-errors">
  <xsl:param name="message"/>
  <text>
    <xsl:value-of select="$message"/>
  </text>
</xsl:template>

<xsl:template match="/">
  <html>
  <body>
    <xsl:variable name="errors">
      <xsl:apply-templates select="$form_model/xf:bind"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="normalize-space($errors)">
        <xsl:call-template name="errors-list">
          <xsl:with-param name="errors">
            <xsl:value-of select="$errors"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="no-errors">
          <xsl:with-param name="message" select="$no_errors_message"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </body>
  </html>
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

<xsl:template match="xf:instance/data/*" mode="constraint-data">
  <xsl:param name="message" />
  <xsl:param name="constraint" />
  <xsl:if test="not(dyn:evaluate($constraint))">
    <xsl:call-template name="error-item">
      <xsl:with-param name="message" select="$message" />
    </xsl:call-template>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
