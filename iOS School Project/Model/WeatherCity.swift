//
//  WeatherCity.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 28/10/2023.
//

import Foundation
struct WeatherCity: Identifiable, Codable{
    var id = UUID()
    let city: City
    let location: Location
    let weather: Weather
    let pollution: Pollution
    
  
}

