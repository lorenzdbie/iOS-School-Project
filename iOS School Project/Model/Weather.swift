//
//  Weather.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 28/10/2023.
//

import Foundation

struct Weather: Codable, Hashable{
    let timeStamp: String
    let temperature: Float
    let atmosphericPressure: Float
    let humidity: Float
    let windSpeed: Float
    let windDirection: Float
    let weatherIcon: String
}
