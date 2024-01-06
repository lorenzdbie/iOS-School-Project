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
    private let locationProvider = LocalLocationDataProvider()
    private let apiService: ApiService
    
    @Published var cityList: [WeatherCity]  = [] {
        didSet{
            autosave()
        }
    }
    @Published var currentCity: WeatherCity
    @Published var localCity: WeatherCity?
    @Published var error: Error?
    private var long:Double = 0
    private var lat: Double = 0
  
    
    private let autosaveURL: URL = URL.documentsDirectory.appendingPathComponent("Autosaved.cityList")
    
    init(apiService: ApiService) {
        self.apiService = apiService
        if let data = try? Data(contentsOf: autosaveURL),
           let autosavedWeatherCityList = try? [WeatherCity](json: data){
            cityList = autosavedWeatherCityList
            currentCity = autosavedWeatherCityList[0]
        } else{
            cityList = cityProvider.getWeatherCityData()
            currentCity = cityProvider.defaultWeather
        }
        if LocationManager.shared.userLocation != nil{
            long = LocationManager.shared.userLocation?.coordinate.longitude ?? 0
            lat = LocationManager.shared.userLocation?.coordinate.latitude ?? 0
            loadLocationData()
        }
    }
    
    private func autosave(){
        save(to: autosaveURL)
        print("Autosaved to: \(autosaveURL)")
    }
    
    private func save(to url: URL){
        do {
            let data = try cityList.json()
            try data.write(to: url)
        } catch let error {
            print("Weathercity document: error while saving \(error.localizedDescription)")
        }
    }
    
      
    func handleRefresh(){
        if LocationManager.shared.userLocation != nil{
            long = LocationManager.shared.userLocation?.coordinate.longitude ?? 0
            lat = LocationManager.shared.userLocation?.coordinate.latitude ?? 0
            loadLocationData()
            refreshCityData()
        }
    }
    
    private func loadLocationData(){
        Task(priority: .high){
           try await fetchLocationData()
        }
    }
    private func refreshCityData(){
        for index in 0..<cityList.count{
            let oldCityData = cityList[index]
            Task(priority: .medium){
                 try await fetchRefreshCityData(listIndex: index,country: oldCityData.city.state.country.name, state: oldCityData.city.self.state.name, city: oldCityData.city.self.name)
                }
        }
    }
    
    func addCity(country:String, state: String, city: String){
        Task(priority: .medium){
            try await fetchCityData(country:country, state:state, city: city)
        }
    }

//MARK: - Async/Await
    @MainActor
    private func fetchLocationData() async throws {
            do {
                let localCity = try await apiService.fetchLocationDataAsync(long: long, lat: lat)
                self.localCity = localCity
            } catch {
                self.error = error
            }
        }
    
    @MainActor
    private func fetchCityData(country:String, state: String, city: String) async throws {
        do {
            let city = try await apiService.fetchCityDataAsync(country: country, state: state, city: city)
            self.cityList.append(city)
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    private func fetchRefreshCityData(listIndex: Int, country:String, state: String, city: String) async throws {
        do {
            let city = try await apiService.fetchCityDataAsync(country: country, state: state, city: city)
            self.cityList[listIndex] = city
        } catch {
            self.error = error
        }
    }
}
