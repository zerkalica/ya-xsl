<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xf="http://www.w3.org/2002/xforms"
    xmlns:my="http://example.com/myns"
>

<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:variable name="form_model" select="/html:html/html:head/xf:model"/>
<xsl:template match="/">
  <html>
  <body>
      <xsl:apply-templates select="$form_model/xf:submission"/>
      <script src="./main.js"></script>
      <script>
        <xsl:text>
          App.attachValidator('.xform');
        </xsl:text>
      </script>
  </body>
  </html>
</xsl:template>

<xsl:template match="xf:submission">
  <form class="xform">
    <xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
    <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
    <xsl:attribute name="method"><xsl:value-of select="@method"/></xsl:attribute>
    <xsl:apply-templates select="/html:html/html:body/my:form/*"/>
  </form>
</xsl:template>

<xsl:template name="form-element-attributes">
  <xsl:param name="ref"/>
  <xsl:variable name="element_meta" select="$form_model/xf:bind[@id=$ref]"/>
  <xsl:attribute name="id"><xsl:value-of select="@ref"/></xsl:attribute>
  <xsl:attribute name="name"><xsl:value-of select="@ref"/></xsl:attribute>
  <xsl:if test="$element_meta/@required = 'true()'">
    <xsl:attribute name="required">required</xsl:attribute>
  </xsl:if>
  <xsl:if test="$element_meta/@type = 'xf:decimal'">
    <xsl:attribute name="type">number</xsl:attribute>
  </xsl:if>
  <xsl:attribute name="data-constraint">
    <xsl:value-of select="$element_meta/@constraint"/>
  </xsl:attribute>
  <xsl:attribute name="data-error">
    <xsl:value-of select="xf:alert"/>
  </xsl:attribute>
</xsl:template>

<xsl:template match="xf:input">
  <xsl:param name="ref" select="@ref"/>
  <div class="form-input xform-element-wrapper">
    <label class="form-input-label">
      <xsl:attribute name="for"><xsl:value-of select="@ref"/></xsl:attribute>
      <xsl:value-of select="xf:label" />
    </label>
    <input class="form-input-value xform-validatable-element">
      <xsl:call-template name="form-element-attributes">
        <xsl:with-param name="ref" select="@ref"/>
      </xsl:call-template>
      <xsl:attribute name="value">
        <xsl:value-of select="$form_model/xf:instance/data/*[name()=$ref]"/>
      </xsl:attribute>
    </input>
    <div class="form-error xform-validatable-error-placeholder"></div>
  </div>
</xsl:template>

<xsl:template match="xf:select1">
  <xsl:param name="ref" select="@ref"/>
  <div class="form-select xform-element-wrapper">
    <label class="form-select-label">
      <xsl:attribute name="for"><xsl:value-of select="$ref"/></xsl:attribute>
      <xsl:value-of select="xf:label" />
    </label>
    <select class="form-select-values xform-validatable-element">
      <xsl:call-template name="form-element-attributes">
        <xsl:with-param name="ref" select="@ref"/>
      </xsl:call-template>
      <xsl:apply-templates match="xf:item">
        <xsl:with-param name="element_value" select="$form_model/xf:instance/data/*[name()=$ref]"/>
      </xsl:apply-templates>
    </select>
    <div class="form-error xform-validatable-error-placeholder"></div>
  </div>
</xsl:template>
<xsl:template match="xf:select1/xf:label"/>

<xsl:template match="xf:select1/xf:item">
  <xsl:param name="element_value" />
  <option class="form-select-option">
    <xsl:if test="xf:value/text()=$element_value">
      <xsl:attribute name="selected">selected</xsl:attribute>
    </xsl:if>
    <xsl:attribute name="value">
      <xsl:value-of select="xf:value"/>
    </xsl:attribute>
    <xsl:value-of select="xf:label"/>
  </option>
</xsl:template>

<xsl:template match="xf:select">
  <xsl:param name="ref" select="@ref"/>
  <div class="form-select-multiple xform-element-wrapper">
    <label class="form-select-multiple-label">
      <xsl:attribute name="for"><xsl:value-of select="@ref"/></xsl:attribute>
      <xsl:value-of select="xf:label" />
    </label>
    <div class="form-select-multiple-values">
      <xsl:call-template name="form-element-attributes">
        <xsl:with-param name="ref" select="@ref"/>
      </xsl:call-template>
      <xsl:apply-templates match="xf:item">
        <xsl:with-param name="ref" select="@ref"/>
        <xsl:with-param name="element_value" select="$form_model/xf:instance/data/*[name()=$ref]"/>
      </xsl:apply-templates>
    </div>
    <div class="form-error xform-validatable-error-placeholder"></div>
  </div>
</xsl:template>

<xsl:template match="xf:select/xf:label"/>

<xsl:template match="xf:select/xf:item">
  <xsl:param name="element_value" />
  <xsl:param name="ref" />
  <label class="form-select-multiple-values xform-validatable-element-checkboxes">
    <input type="checkbox" class="form-select-multiple-values-value">
      <xsl:attribute name="name">
        <xsl:value-of select="$ref"/>
      </xsl:attribute>
      <xsl:if test="xf:value=$element_value">
        <xsl:attribute name="checked">checked</xsl:attribute>
      </xsl:if>
      <xsl:attribute name="value">
        <xsl:value-of select="xf:value"/>
      </xsl:attribute>
    </input>
    <span class="form-select-multiple-values-label">
      <xsl:value-of select="xf:label"/>
    </span>
  </label>
</xsl:template>


<xsl:template match="xf:submit">
  <button class="form-submit xform-submit">
    <xsl:value-of select="xf:label"/>
  </button>
</xsl:template>

</xsl:stylesheet>
