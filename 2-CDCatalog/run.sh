#!/bin/sh

xmllint --noout --relaxng data.rng data.xml
xsltproc --stringparam year "2014" -o output-filtered-year.html format.xsl data.xml

xsltproc -o output-sorted-label.html --stringparam order "ascending" --stringparam sortparam "label" format.xsl data.xml



