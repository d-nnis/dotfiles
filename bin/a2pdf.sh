#!/usr/bin/env bash

SCRIPTDIR="$( pwd )"

a2x -v -f pdf -L --asciidoc-opts="-v -b docbook -d book -a lang=de" --dblatex-opts="-V -T db2latex" $1
#a2x -v -f pdf -L --asciidoc-opts="-v -b docbook -d book -f /home/dennis/owncloud_maw/Mag/kollektivistisch/lang-de.conf" --dblatex-opts="-V -T db2latex" $1
#a2x -v -f pdf -L --asciidoc-opts="-v -b docbook -a lang=de" --dblatex-opts="-V -T db2latex --xsl-user=fo.xsl" $1
#a2x -v -f pdf -L --asciidoc-opts="-v -b docbook -d book" --dblatex-opts="-V -T db2latex" $1


#a2x -v -f pdf -L -dbook --asciidoc-opts="-v -b docbook -d book -a lang=de" --fop $1
# no Symbol 700, no Zapfdingbats 700
