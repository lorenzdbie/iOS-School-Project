//
//  City.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import Foundation

struct Country: Identifiable, Equatable, Codable{
let name:String
    var id =  UUID()
    
    init(_ name: String) {
        self.name = name
    }
}

struct CityState: Identifiable, Equatable, Codable{
    let name: String
    let country: Country
    var id =  UUID()
    
    init(_ name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

struct City: Identifiable, Equatable, Codable{
    let name: String
    let state: CityState
    var id =  UUID()
    
    init(_ name: String, state: CityState) {
        self.name = name
        self.state = state
    }
}
