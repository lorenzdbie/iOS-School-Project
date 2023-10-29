//
//  City.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import Foundation

struct Country: Identifiable, Equatable{
let name:String
    let id =  UUID()
    
    init(_ name: String) {
        self.name = name
    }
}

struct CityState: Identifiable, Equatable{
    let name: String
    let country: Country
    let id =  UUID()
    
    init(_ name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

struct City: Identifiable, Equatable{
    let name: String
    let state: CityState
    let id =  UUID()
    
    init(_ name: String, state: CityState) {
        self.name = name
        self.state = state
    }
}
