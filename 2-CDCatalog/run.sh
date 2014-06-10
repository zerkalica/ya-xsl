#!/bin/sh

#xmllint --noout --relaxng data.rng data.xml
xsltproc --stringparam year "2014" -o output.xml format.xsl data.xml

xsltproc -o output2.xml --stringparam order "descending" --stringparam sortparam "year" format.xsl data.xml



