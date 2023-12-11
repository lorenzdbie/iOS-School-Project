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
        refreshCityData()
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






//MARK: - Async/Await
//extension WeatherViewModel{
//    @MainActor
//    func fetchLocationDataFromAPI() async throws {
//        let urlString = "\(baseUrl)nearest_city?lat=\(lat)&lon=\(long)&\(secretKey)"
//        do{
//            guard let url = URL(string: urlString) else { throw WeatherError.invalidURL }
//            //            print(url)
//            let (data, response) = try await URLSession.shared.data(from: url)
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WeatherError.serverError }
//            //            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            //            print("API Response: \(json)")
//            guard let weatherCity = try? parseWeatherCity(from: data) else { throw WeatherError.invalidData }
//            //            print(weatherCity)
//            self.localCity = weatherCity
//        }catch {
//            self.error = error
//        }
//    }
    
//    func loadData(){
//        Task(priority: .medium){
//            try await fetchLocationDataFromAPI()
//        }
//    }
    
    
//    @MainActor
//    func fetchCityDataAsync(cityUrl: String) async throws {
//        do{
//            guard let url = URL(string: cityUrl) else { throw WeatherError.invalidURL }
//            //            print(url)
//            let (data, response) = try await URLSession.shared.data(from: url)
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WeatherError.serverError }
//            //            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            //            print("API Response: \(json)")
//            guard let weatherCity = try? parseWeatherCity(from: data) else { throw WeatherError.invalidData }
//            //            print(weatherCity)
//            self.cityList.append(weatherCity)
//        }catch {
//            self.error = error
//        }
//    }
    
//    func loadCityData(cityUrl: String){
//        Task(priority: .medium){
//            try await fetchCityDataAsync(cityUrl: cityUrl)
//        }
//    }
    
    
//    func parseWeatherCity(from jsonData: Data) throws -> WeatherCity? {
//        let jsonDecoder = JSONDecoder()
//        let weatherData = try jsonDecoder.decode(WeatherData.self, from: jsonData)
//        
//        let city = City(
//            weatherData.data.city,
//            state: CityState(
//                weatherData.data.state,
//                country: Country(
//                    weatherData.data.country)
//            ))
//        
//        let location = Location(
//            longitude: Double(weatherData.data.location.coordinates[0]),
//            latitude: Double(weatherData.data.location.coordinates[1])
//        )
//        
//        let weather = Weather(
//            timeStamp: weatherData.data.current.weather.ts,
//            temperature: weatherData.data.current.weather.tp,
//            atmosphericPressure: weatherData.data.current.weather.pr,
//            humidity: weatherData.data.current.weather.hu,
//            windSpeed: weatherData.data.current.weather.ws,
//            windDirection: weatherData.data.current.weather.wd,
//            weatherIcon: weatherData.data.current.weather.ic
//        )
//        
//        let pollution = Pollution(
//            timeStamp: weatherData.data.current.pollution.ts,
//            aqiUsa: weatherData.data.current.pollution.aqius,
//            mainUsa: weatherData.data.current.pollution.mainus,
//            aqiChina: weatherData.data.current.pollution.aqicn,
//            mainChina: weatherData.data.current.pollution.maincn
//        )
//        
//        return WeatherCity(city: city, location: location, weather: weather, pollution: pollution)
//    }
//}


//struct WeatherData: Codable {
//    let data: WeatherDataInfo
//    let status: String
//}
//
//struct WeatherDataInfo: Codable {
//    let city: String
//    let country: String
//    let state: String
//    let current: WeatherDetails
//    let location: LocationInfo
//}
//
//struct WeatherDetails: Codable {
//    let weather: WeatherInfo
//    let pollution: PollutionInfo
//}
//
//struct WeatherInfo: Codable {
//    let ts: String
//    let hu: Float
//    let ic: String
//    let pr: Float
//    let tp: Float
//    let wd: Float
//    let ws: Float
//}
//
//struct PollutionInfo: Codable {
//    let ts: String
//    let aqicn: Float
//    let maincn: String
//    let aqius: Float
//    let mainus: String
//}
//
//struct LocationInfo: Codable {
//    let coordinates: [Double]
//    let type: String
//}


