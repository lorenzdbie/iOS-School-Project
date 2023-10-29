//
//  LocalLocatoinDataProvider.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import Foundation

struct LocationDataProvider{
    let countries:[Country]
    let states: [CityState]
    let cities: [City]
    
    init(){
        countries = [Country("Belgium"), Country("USA")]
        states = [CityState("Flanders", country: countries[0]), CityState("New York", country: countries[1])]
        cities = [City("Gent", state: states[0]), City("New York City", state: states[1])]
    }
}
