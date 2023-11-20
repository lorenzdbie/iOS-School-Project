//
//  ApiService.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 20/11/2023.
//

import Foundation

protocol ApiService {
    
    var baseUrl:String { get }
    
    var secretKey: String { get }
    
    func fetchCountriesAsync() async throws -> [ApiCountry]
    
    func fetchStatesAsync(country: String) async throws -> [ApiState]
    
    func fetchCitiesAsync(country: String, state: String) async throws -> [ApiCity]
    
    func fetchLocationDataAsync(long : Double, lat: Double) async throws -> WeatherCity
    
    func fetchCityDataAsync(country: String, state: String, city: String) async throws -> WeatherCity
    
    
}
