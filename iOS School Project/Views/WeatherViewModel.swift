//
//  WeatherViewModel.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 28/10/2023.
//

import SwiftUI

class WeatherViewModel: ObservableObject{
    
    private let cityProvider = LocalWeatherCityDataProvider()
   let locationProvider = LocationDataProvider()
    
    @Published var cityList: [WeatherCity]
    @Published var currentCity: WeatherCity
    
    
    init() {
        cityList = cityProvider.getWeatherCityData()
        currentCity = cityProvider.defaultWeather
    }
}
