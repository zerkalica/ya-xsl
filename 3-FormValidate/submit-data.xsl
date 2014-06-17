<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xf="http://www.w3.org/2002/xforms"
    xmlns:exsl="http://exslt.org/common"
    xmlns:my="http://example.com/myns"
>

<xsl:variable name="form_submit_string">
  <my:data>
    <my:name>И</my:name>
    <my:age>18</my:age>
    <my:sex>F</my:sex>
    <my:documents>passport</my:documents>
    <my:hidden_value>10</my:hidden_value>
  </my:data>
</xsl:variable>

<xsl:variable name="form_submit" select="exsl:node-set($form_submit_string)/my:data"/>
</xsl:stylesheet>
