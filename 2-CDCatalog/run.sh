#!/bin/sh

#xmllint --noout --relaxng data.rng data.xml
xsltproc --stringparam form_name "form2" -o output.xml format.xsl data.xml
