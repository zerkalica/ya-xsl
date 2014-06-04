#!/bin/sh

xsltproc --param form_name "/forms/form[@id='form2']" -o output.xml format.xsl data.xml
