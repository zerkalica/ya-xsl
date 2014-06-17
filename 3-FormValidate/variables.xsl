<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xf="http://www.w3.org/2002/xforms"
    xmlns:my="http://example.com/myns"
>

  <xsl:variable name="form_view" select="/my:root/my:forms/my:form/*"/>
  <xsl:variable name="form_model" select="/my:root/my:models/xf:model"/>
  <xsl:variable name="form_data" select="$form_model/xf:instance/my:data"/>

  <xsl:variable name="no_errors_message">Нет ошибок</xsl:variable>

</xsl:stylesheet>
