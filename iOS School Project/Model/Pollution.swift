//
//  Pollution.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 28/10/2023.
//

import Foundation

struct Pollution: Codable, Hashable{
    let timeStamp: String
    let aqiUsa: Float
    let mainUsa: String
    let aqiChina: Float
    let mainChina: String
}
