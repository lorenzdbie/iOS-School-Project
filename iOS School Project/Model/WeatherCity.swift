//
//  WeatherCity.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 28/10/2023.
//

import Foundation
struct WeatherCity: Identifiable{
    let id = UUID()
    let city: String
    let state: String
    let country: String
    let location: Location
    let weather: Weather
    let pollution: Pollution
}

