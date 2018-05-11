use Airport_db
db.time.drop()
var before = new Date()
db.airport.aggregate([{
        $group: {
            _id: "$Origin_airport",
            sumPassengers: {
                $sum: "$Passengers"
            }
        }
    },

    {
        $out: "Origin_airport_sumPassengers"
    }
]);


var after = new Date()
execution_mills1 = after - before
db.time.save({
    "number": execution_mills1
});

var before = new Date()
var mapFunction1 = function() {
    emit(this.Origin_airport, this.Flights);
};
var reduceFunction1 = function(keyCustId, valuesPrices) {
    return Array.sum(valuesPrices);
};
db.airport.mapReduce(
    mapFunction1,
    reduceFunction1, {
        out: "Origin_airport_Flight"
    }
);
var after = new Date()
execution_mills2 = after - before
db.time.save({
    "number": execution_mills2
});



var before = new Date()
db.airport.aggregate(
    [{
            $match: {
                Origin_airport: "ATL"
            }
        },
        {
            $group: {
                _id: {
                    Origin_airport: "$Origin_airport",
                    Year: {
                        $substr: ["$Fly_date", 0, 4]
                    }
                },
                sumPassengers: {
                    $sum: "$Passengers"
                }
            }
        },
        {
            $sort: {
                sumPassengers: -1
            }
        },
        {
            $limit: 50
        },
        {
            $out: "ATL_Year_sumPassengers"
        }
    ]
)



var after = new Date()
execution_mills3 = after - before
db.time.save({
    "number": execution_mills3
});

db.airport.createIndex({
    "Origin_airport": 1
})
var before = new Date()
db.airport.aggregate(
    [{
            $match: {
                Origin_airport: "ATL"
            }
        },
        {
            $group: {
                _id: {
                    Origin_airport: "$Origin_airport",
                    Year: {
                        $substr: ["$Fly_date", 0, 4]
                    }
                },
                sumPassengers: {
                    $sum: "$Passengers"
                }
            }
        },
        {
            $sort: {
                sumPassengers: -1
            }
        },
        {
            $limit: 50
        },
        {
            $out: "ATL_Year_sumPassengers3a"
        }
    ]
)
var after = new Date()
execution_mills31 = after - before
db.time.save({
    "number": execution_mills31
});
db.airport.dropIndex({
    "Origin_airport": 1
})


db.airport.aggregate(
    [{
            $match: {
                Origin_airport: "ATL"
            }
        },
        {
            $group: {
                _id: {
                    Origin_airport: "$Origin_airport",
                    Year: {
                        $substr: ["$Fly_date", 0, 4]
                    }
                },
                sumFlights: {
                    $sum: "$Flights"
                }
            }
        },
        {
            $sort: {
                sumFlights: -1
            }
        },
        {
            $limit: 50
        },
        {
            $out: "ATL_Year_sumFlights"
        }
    ]
)



db.airport.aggregate(
    [{
            $group: {
                _id: {
                    Origin_airport: "$Origin_airport",
                    Destination_airport: "$Destination_airport",
                    Org_airport_lat: "$Org_airport_lat",
                    Org_airport_long: "$Org_airport_long",
                    Dest_airport_lat: "$Dest_airport_lat",
                    Dest_airport_long: "$Dest_airport_long"
                },
                sumFlights: {
                    $sum: "$Flights"
                }
            }
        },
        {
            $sort: {
                sumFlights: -1
            }
        },
        {
            $out: "AllFlights"
        }
    ]
)
