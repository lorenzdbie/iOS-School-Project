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
        
    }
    
    func getCitiesForState(state: String){
        self.state = state
        Task(priority: .medium){
            try await fetchCitiesData()
        }
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
