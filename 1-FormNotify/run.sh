#!/bin/sh

xsltproc --param form_name "/forms/form[@id='form1']" -o output.xml format.xsl data.xml
