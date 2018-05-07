#!/bin/sh
#mongo Airport_db --eval "db.dropDatabase()"
#mongoimport --db Airport_db --collection airport --type csv --headerline --file airport.csv

#1 zapytanie
(mongo < zapytanie1.json) > wynik.json
tail -n +5 wynik.json | egrep -v "^>|^bye" > wynik1.csv
cat wynik1.csv | tr -d '{},:' > wynik1plot.csv
rm wynik1.csv

#2 zapytanie
(mongo < zapytanie2.json) > wynik.json
tail -n +16 wynik.json | egrep -v "^>|^bye" > wynik2.csv
cat wynik2.csv | tr -d '{},:' > wynik2plot.csv
rm wynik2.csv

#3 zapytanie 
(mongo < zapytanie3.json) > wynik.json
tail -n +5 wynik.json | egrep -v "^>|^bye" > wynik3.csv
cat wynik3.csv | tr -d '{},:' > wynik3plot.csv
rm wynik3.csv

#4 zapytanie 
(mongo < zapytanie4.json) > wynik.json
tail -n +5 wynik.json | egrep -v "^>|^bye" > wynik4.csv
cat wynik4.csv | tr -d '{},:' > wynik4plot.csv
rm wynik4.csv

#5 zapytanie
(mongo < zapytanie5.json) > wynik.json
tail -n +6 wynik.json | egrep -v "^>|^bye" > wynik5.csv
cat wynik5.csv | tr -d '{},:' > wynik5map.csv
rm wynik5.csv

#6 zapytanie
(mongo < zapytanie6.json) > wynik.json
tail -n +5 wynik.json | egrep -v "^>|^bye" > wynik6.csv
cat wynik6.csv | tr -d '{},:' > wynik6map.csv

rm wynik6.csv

Rscript zapytania.R

rm wynik1plot.csv
rm wynik2plot.csv
rm wynik3plot.csv
rm wynik4plot.csv
rm wynik5map.csv
rm wynik6map.csv
rm wynik.json
#rm Rplots.pdf
