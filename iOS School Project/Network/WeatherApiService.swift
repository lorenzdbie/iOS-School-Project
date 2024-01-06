//
//  WeatherApiService.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 20/11/2023.
//

import Foundation

class WeatherApiService: ApiService {
    
    var baseUrl: String = "https://api.airvisual.com/v2/"
    
    var secretKey: String = "key=efc93cd2-4e04-445e-beec-c8e9d2b5aca1"
    
    func fetchCountriesAsync() async throws -> [ApiCountry] {
        let urlString =  "\(baseUrl)countries?\(secretKey)"
        do{
            guard let url = URL(string: urlString) else { throw WeatherError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WeatherError.serverError }
            
            guard let countries = try? JSONDecoder().decode(CountriesResponse.self, from: data) else { throw WeatherError.invalidData }
            
            return countries.data
        }
    }
    
    func fetchStatesAsync(country: String) async throws -> [ApiState] {
        let urlString = "\(baseUrl)states?country=\(country)&\(secretKey)"
        do{
            guard let url = URL(string: urlString) else { throw WeatherError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WeatherError.serverError }
            
            guard let states = try? JSONDecoder().decode(StateResponse.self, from: data) else { throw WeatherError.invalidData }
            
            return states.data
        }
    }
    
    func fetchCitiesAsync(country: String, state: String) async throws -> [ApiCity] {
        let urlString = "\(baseUrl)cities?state=\(state)&country=\(country)&\(secretKey)"
        do{
            guard let url = URL(string: urlString) else { throw WeatherError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WeatherError.serverError }
            
            guard let cities = try? JSONDecoder().decode(CityResponse.self, from: data) else { throw WeatherError.invalidData }
            return cities.data
            
        }
    }
    

    func fetchLocationDataAsync(long: Double, lat: Double) async throws -> WeatherCity {
        let urlString = "\(baseUrl)nearest_city?lat=\(lat)&lon=\(long)&\(secretKey)"
        do{
            guard let url = URL(string: urlString) else { throw WeatherError.invalidURL }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WeatherError.serverError }

            guard let weatherCity = try? parseWeatherCity(from: data) else { throw WeatherError.invalidData }
            
            return weatherCity
        }
    }
    
    
    func fetchCityDataAsync(country: String, state: String, city: String) async throws -> WeatherCity {
        let urlString = "\(baseUrl)city?city=\(city)&state=\(state)&country=\(country)&\(secretKey)"
        do{
            guard let url = URL(string: urlString) else { throw WeatherError.invalidURL }

            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WeatherError.serverError }

            guard let weatherCity = try? parseWeatherCity(from: data) else { throw WeatherError.invalidData }

            return weatherCity
        }
    }
    
    
    func parseWeatherCity(from jsonData: Data) throws -> WeatherCity? {
        let jsonDecoder = JSONDecoder()
        let weatherData = try jsonDecoder.decode(WeatherData.self, from: jsonData)
        
        let city = City(
            weatherData.data.city,
            state: CityState(
                weatherData.data.state,
                country: Country(
                    weatherData.data.country)
            ))
        
        let location = Location(
            longitude: Double(weatherData.data.location.coordinates[0]),
            latitude: Double(weatherData.data.location.coordinates[1])
        )
        
        let weather = Weather(
            timeStamp: weatherData.data.current.weather.ts,
            temperature: weatherData.data.current.weather.tp,
            atmosphericPressure: weatherData.data.current.weather.pr,
            humidity: weatherData.data.current.weather.hu,
            windSpeed: weatherData.data.current.weather.ws,
            windDirection: weatherData.data.current.weather.wd,
            weatherIcon: weatherData.data.current.weather.ic
        )
        
        let pollution = Pollution(
            timeStamp: weatherData.data.current.pollution.ts,
            aqiUsa: weatherData.data.current.pollution.aqius,
            mainUsa: weatherData.data.current.pollution.mainus,
            aqiChina: weatherData.data.current.pollution.aqicn,
            mainChina: weatherData.data.current.pollution.maincn
        )
        
        return WeatherCity(city: city, location: location, weather: weather, pollution: pollution)
    }
    
    
}
// MARK - API structs

struct ApiCountry: Codable, Hashable{
    let country: String
}
struct CountriesResponse: Decodable {
    let status: String
    let data: [ApiCountry]
}


struct ApiState: Codable, Hashable{
    var state: String
}
struct StateResponse: Decodable{
    let status: String
    let data: [ApiState]
}


struct ApiCity: Codable, Hashable{
    var city: String
}
struct CityResponse: Decodable{
    let status: String
    let data: [ApiCity]
}

struct WeatherData: Codable {
    let data: WeatherDataInfo
    let status: String
}

struct WeatherDataInfo: Codable {
    let city: String
    let country: String
    let state: String
    let current: WeatherDetails
    let location: LocationInfo
}

struct WeatherDetails: Codable {
    let weather: WeatherInfo
    let pollution: PollutionInfo
}

struct WeatherInfo: Codable {
    let ts: String
    let hu: Float
    let ic: String
    let pr: Float
    let tp: Float
    let wd: Float
    let ws: Float
}

struct PollutionInfo: Codable {
    let ts: String
    let aqicn: Float
    let maincn: String
    let aqius: Float
    let mainus: String
}

struct LocationInfo: Codable {
    let coordinates: [Double]
    let type: String
}
