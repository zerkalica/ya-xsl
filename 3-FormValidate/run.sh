#!/bin/sh

xsltproc -o output.html format.xsl form-data.xml
xsltproc -o output-validation.xml validation.xsl form-data.xml
