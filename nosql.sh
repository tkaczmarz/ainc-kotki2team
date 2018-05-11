#!/bin/sh
#mongo Airport_db --eval "db.dropDatabase()"
#mongoimport --db Airport_db --collection airport --type csv --headerline --file airport.csv

#1 zapytanie
mongo < zapytanie1.json
mongoexport --db Airport_db --collection Origin_airport_sumPassengers --type=csv --sort '{sumPassengers: -1}' --limit 50 --out wynik1plot.csv -f _id,sumPassengers

#2 zapytanie
mongo < zapytanie2.json
mongoexport --db Airport_db --collection Origin_airport_Flight --sort '{value: -1}' --limit 50 --type=csv --out wynik2plot.csv -f _id,value

#3 zapytanie 
mongo < zapytanie3.json
mongoexport --db Airport_db --collection ATL_Year_sumPassengers --type=csv --out wynik3plot.csv -f _id.Year,sumPassengers
mongo < zapytanie3a.json

#4 zapytanie 
mongo < zapytanie4.json
mongoexport --db Airport_db --collection ATL_Year_sumFlights --type=csv --out wynik4plot.csv -f _id.Year,sumFlights

#5 zapytanie
mongo < zapytanie5.json
mongoexport --db Airport_db --collection AllOrigin_airport --type=csv --out wynik5plot.csv -f _id.Origin_airport,_id.Org_airport_lat,_id.Org_airport_long

#6 zapytanie
mongo < zapytanie6.json
mongoexport --db Airport_db --collection AllFlights --type=csv --out wynik6plot.csv -f _id.Origin_airport,_id.Destination_airport,_id.Org_airport_lat,_id.Org_airport_long,_id.Dest_airport_lat,_id.Dest_airport_long,sumFlights

#pobieranie czasow
mongoexport --db Airport_db --collection time --type=csv --out wynikTime.csv -f number


Rscript zapytania.R
