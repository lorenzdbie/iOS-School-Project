//
//  WeatherViewModel.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 28/10/2023.
//

import SwiftUI
import CoreLocation

class WeatherViewModel: ObservableObject{
    
    private let cityProvider = LocalWeatherCityDataProvider()
   let locationProvider = LocationDataProvider()
    private let locationManager = LocationManager()
    
    @Published var cityList: [WeatherCity]
    @Published var currentCity: WeatherCity
    @Published var long: Double = 0
    @Published var lat: Double = 0
    
    
    init() {
        cityList = cityProvider.getWeatherCityData()
        currentCity = cityProvider.defaultWeather
        
    }
}


