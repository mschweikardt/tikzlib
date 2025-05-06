#!/bin/bash

rm -f *.pdf
rm -f *.svg

cd figs
rm -f *.pdf
rm -f *.log
rm -f *.aux
cd ..

cd test
rm -f *.pdf
rm -f *.log
rm -f *.aux
cd ..
