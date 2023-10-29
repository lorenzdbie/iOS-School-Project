//
//  LocalWeatherDataProvider.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 28/10/2023.
//

import Foundation

struct LocalWeatherCityDataProvider{
    
    var defaultWeather: WeatherCity
    var weatherCityList: [WeatherCity]
    
    init(){
        weatherCityList = [
            WeatherCity(
                city: City(
                     "Gent",
                    state: CityState(
                         "Flanders",
                        country: Country(
                             "Belgium")
                    )
                ),
                location: Location(
                    longitude: 3.80873543079248,
                    latitude: 51.1501360922306),
                weather: Weather(
                    timeStamp: "2023-10-28T09:00:00.000Z",
                    temperature: 12,
                    atmosphericPressure: 993,
                    humidity: 81,
                    windSpeed: 5.36,
                    windDirection: 194,
                    weatherIcon: "04d"),
                pollution: Pollution(
                    timeStamp: "2023-10-28T08:00:00.000Z",
                    aqiUsa: 23,
                    mainUsa: "o3",
                    aqiChina: 18,
                    mainChina: "o3")
                ),
            WeatherCity(
                city: City(
                     "New York City",
                    state: CityState(
                         "New York",
                        country: Country(
                             "USA")
                    )
                ),
                location: Location(
                    longitude: -73.928596,
                    latitude: 40.694401),
                weather: Weather(
                    timeStamp: "2023-10-28T10:00:00.000Z",
                    temperature: 17,
                    atmosphericPressure: 1016,
                    humidity: 81,
                    windSpeed: 4.12,
                    windDirection: 200,
                    weatherIcon: "02n"),
                pollution: Pollution(
                    timeStamp: "2023-10-28T10:00:00.000Z",
                    aqiUsa: 43,
                    mainUsa: "p2",
                    aqiChina: 15,
                    mainChina: "p2")
                )
        ]
    defaultWeather = weatherCityList[0]
    }
    
    func getWeatherCityData() -> [WeatherCity] {
        return weatherCityList
    }
}
