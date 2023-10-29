//
//  LocalLocatoinDataProvider.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import Foundation

struct LocationDataProvider{
//    let countries:[Country]
//    let states: [CityState]
//    let cities: [City]
    
    var countries = ["Belgium":
                        ["Flanders":
                            ["Gent", "Brugge", "Knokke"],
                         "Brussels":
                            ["Brussels", "Anderlecht"]
                        ],
                     "USA":
                        ["New York":
                            ["New York City"],
                         "California":
                            ["San fransisco", "Los Angeles"]
                        ]
    ]
    
    func getCountries() -> [String]{
        return Array(countries.keys)
    }
    
    func getStates(country: String) -> [String]? {
        return countries[country]?.keys.sorted()
    }

    func getCities(country: String, state: String) -> [String]? {
        return countries[country]?[state]?.sorted()
    }
    
//    init(){
//        countries = [Country("Belgium"), Country("USA")]
//        states = [CityState("Flanders", country: countries[0]),CityState("Brussels", country: countries[0]), CityState("New York", country: countries[1]), CityState("California", country: countries[1])]
//        cities = [City("Gent", state: states[0]), City("New York City", state: states[1])]
//    }
//    func getCountries() -> [Country]{
//        return countries
//    }
//    
//    func getStates(countryIndex: Int) -> [CityState]{
//        return states.filter{ $0.country == countries[countryIndex]}
//    }
//  
//    func getCities(stateIndex: Int) -> [City]{
//        return cities.filter{$0.state == states[stateIndex]}
//    }
}
