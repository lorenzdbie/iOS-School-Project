//
//  City.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import Foundation

struct Country: Identifiable{
let name:String
    let id =  UUID()
    
    init(_ name: String) {
        self.name = name
    }
}

struct CityState{
    let name: String
    let country: Country
    
    init(_ name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

struct City{
    let name: String
    let state: CityState
    
    init(_ name: String, state: CityState) {
        self.name = name
        self.state = state
    }
}
