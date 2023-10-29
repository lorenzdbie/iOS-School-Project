//
//  LocalLocatoinDataProvider.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import Foundation

struct LocationDataProvider{
    
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
}
