#!/bin/sh

xsltproc --stringparam form_name test1 -o output.xml format.xsl data.xml
