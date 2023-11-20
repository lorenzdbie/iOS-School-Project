//
//  AddCityViewModel.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 2/11/2023.
//

import Foundation

class AddCityViewModel: ObservableObject{
    
    private let apiService: ApiService
    @Published var countries = [ApiCountry]()
    @Published var states = [ApiState]()
    @Published var cities = [ApiCity]()
    @Published var error: Error?
    
    private var country = ""
    private var state = ""
//    private var city = ""
    
//    let baseUrl = "https://api.airvisual.com/v2/"
//    let secretKey = "key=efc93cd2-4e04-445e-beec-c8e9d2b5aca1"
    
//    var countriesUrlString: String{
//        "\(baseUrl)countries?\(secretKey)"
//    }
    init (apiService: ApiService) {
        self.apiService = apiService
        getCountries()
    }
    
    func getCountries(){
        Task(priority: .medium){
            try await fetchCountriesData()
        }
    }
    
    func getStatesForCountry(country: String){
        self.country = country
        Task(priority: .medium){
            try await fetchStatesData()
        }
        
       // self.country = country
       // var statesUrlString: String{
       //     "\(baseUrl)states?country=\(country)&\(secretKey)"
       // }
        // loadStatesData(url: statesUrlString)
        
    }
    
    func getCitiesForState(state: String){
        self.state = state
        Task(priority: .medium){
            try await fetchCitiesData()
        }
//        var citiesUrlString: String{
//            "\(baseUrl)cities?state=\(state)&country=\(country)&\(secretKey)"
//        }
//        print(citiesUrlString)
//        loadCitiesData(url: citiesUrlString)
    }
    
//MARK: - Async/Await
    @MainActor
    private func fetchCountriesData() async throws {
        do {
            let countries = try await apiService.fetchCountriesAsync()
            self.countries = countries
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    private func fetchStatesData() async throws {
        do {
            let states = try await apiService.fetchStatesAsync(country: country)
            self.states = states
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    private func fetchCitiesData() async throws {
        do {
            let cities = try await apiService.fetchCitiesAsync(country: country, state: state)
            self.cities = cities
        } catch {
            self.error = error
        }
    }
}

//extension AddCityViewModel{
    
//    @MainActor
//    func fetchCountriesAsync() async throws{
//        do{
//            guard let url = URL(string: countriesUrlString) else { throw WeatherError.invalidURL }
//            let (data, response) = try await URLSession.shared.data(from: url)
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WeatherError.serverError }
//            //            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            //            print("API Response: \(json)")
//            guard let countries = try? JSONDecoder().decode(CountriesResponse.self, from: data) else { throw WeatherError.invalidData }
//            //            print("countries: \(countries)")
//            self.countries = countries.data
//        } catch {
//            self.error = error
//        }
//    }
    
//    func loadCountriesData(){
//        Task(priority: .medium){
//            try await fetchCountriesAsync()
//        }
//    }
    
    
//    @MainActor
//    func fetchStatesAsync(statesUrl: String) async throws{
//        do{
//            guard let url = URL(string: statesUrl) else { throw WeatherError.invalidURL }
//            let (data, response) = try await URLSession.shared.data(from: url)
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WeatherError.serverError }
//            //            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            //            print("API Response: \(json)")
//            guard let states = try? JSONDecoder().decode(StateResponse.self, from: data) else { throw WeatherError.invalidData }
//            //            print("states: \(states)")
//            self.states = states.data
//        } catch {
//            self.error = error
//        }
//    }
//    
//    func loadStatesData(url: String){
//        Task(priority: .medium){
//            try await fetchStatesAsync(statesUrl: url)
//        }
//    }
//    
//    
//    @MainActor
//    func fetchCitiesAsync(citiesUrl: String) async throws{
//        do{
//            guard let url = URL(string: citiesUrl) else { throw WeatherError.invalidURL }
//            let (data, response) = try await URLSession.shared.data(from: url)
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw WeatherError.serverError }
//            //            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            //            print("API Response: \(json)")
//            guard let cities = try? JSONDecoder().decode(CityResponse.self, from: data) else { throw WeatherError.invalidData }
//            //            print("cities: \(cities)")
//            self.cities = cities.data
//        } catch {
//            self.error = error
//        }
//    }
//    
//    func loadCitiesData(url: String){
//        Task(priority: .medium){
//            try await fetchCitiesAsync(citiesUrl: url)
//        }
//    }
//}

//// MARK - API structs
//
//struct ApiCountry: Codable, Hashable{
//    let country: String
//}
//struct CountriesResponse: Decodable {
//    let status: String
//    let data: [ApiCountry]
//}
//
//
//struct ApiState: Codable, Hashable{
//    var state: String
//}
//struct StateResponse: Decodable{
//    let status: String
//    let data: [ApiState]
//}
//
//
//struct ApiCity: Codable, Hashable{
//    var city: String
//}
//struct CityResponse: Decodable{
//    let status: String
//    let data: [ApiCity]
//}

