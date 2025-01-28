#!/bin/bash

REPO=https://github.com/mschweikardt/tikzlib/
IOREPO=https://mschweikardt.github.io/tikzlib/

rm -f *.pdf
rm -f *.svg
rm index.html

echo "<!DOCTYPE html>" > index.html
echo "<html>" >> index.html
echo "  <head>" >> index.html
echo "    <title>tikzlib</title>" >> index.html
echo "    <link rel="stylesheet" href="style.css">" >> index.html
echo "  </head>" >> index.html
echo "  <body>" >> index.html
echo "  <h2>tikzlib</h2>" >> index.html
echo "  <p>Author:  <a href="https://github.com/mschweikardt">Matthias Schweikardt</a></p>" >> index.html
echo "  <p>License: <a href="https://creativecommons.org/licenses/by-sa/4.0">CC BY-SA 4.0</a></p>" >> index.html
echo "  <p>Description: This  <a href="$REPO">repository</a> contains various <a href="https://ctan.org/pkg/pgf">TikZ</a> and <a href="https://ctan.org/pkg/circuitikz">CircuiTikZ</a> figures.</p>" >> index.html
echo "  <p>Repository: <a href="$REPO">Link</a></p>" >> index.html
echo "  <p>Figures:</p>" >> index.html
echo "  <dl>" >> index.html

cd test

for texfile in *.tex; do
  [ -e "$texfile" ] || continue

  file=${texfile%.*}

  pdflatex $texfile
  inkscape --without-gui --file=$file.pdf --export-plain-svg=$file.svg

  cp $file.pdf ./../$file.pdf
  cp $file.svg ./../$file.svg

  echo "      <dt><a href="${REPO}blob/main/figs/$texfile">$texfile</a></dt>" >> ./../index.html
  echo "      <dd><img src = "$file.svg" alt="$file"/></dd>" >> ./../index.html

done

rm -f *.pdf
rm -f *.svg
rm -f *.log
rm -f *.aux

cd ..

echo "  </dl>" >> index.html
echo "  </body>" >> index.html
echo "</html>" >> index.html