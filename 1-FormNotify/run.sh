#!/bin/sh

xsltproc --param form_id "/forms/form[@id=test1]" -o output.xml format.xsl data.xml
