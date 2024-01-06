//
//  DeatailWeatherView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import SwiftUI

struct DetailsWeatherView: View {
    
    let city: WeatherCity
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
            VStack{
                detailHeader.frame(maxWidth: 800).padding(.horizontal, 16)
                Divider()
                ScrollView{
                    weatherDetails.frame(maxWidth: 800).padding(.horizontal, 16)

                    Divider()
                    pollutionDetails.frame(maxWidth: 800).padding(.horizontal, 16)

                    Spacer().frame(height: 30)
                    timeStamp
                }            }
            
            .gradientBackground(colorScheme: colorScheme)
    }
    
    private var timeStamp: some View{
        Text("\(NSLocalizedString("lastUpdated", comment: "")): \(convertDateString(city.weather.timeStamp))")
    }
    
    private var detailHeader: some View{
        HStack(alignment: .firstTextBaseline){
            Spacer()
            Text("\(NSLocalizedString("country", comment: "")): \n" + city.city.state.country.name)
            Spacer()
            Text("\(NSLocalizedString("state", comment: "")): \n" + city.city.state.name)
            Spacer()
            Text("\(NSLocalizedString("city", comment: "")): \n" + city.city.name)
            Spacer()
        }.padding(.bottom, 10).modifier(CommonStyleModifier())
    }
    
    private var weatherDetails: some View {
        VStack{
            Text(NSLocalizedString("weather", comment: "")).font(.title)
            HStack(alignment: .top){
                VStack(){
                    temperature.modifier(CommonStyleModifier())
                    wind.modifier(CommonStyleModifier())
                }
                Spacer().frame(width: 15)
                VStack{
                    weatherIcon(city.weather.weatherIcon).frame(width: 100).modifier(CommonStyleModifier())
                    Spacer().frame(height: 35)
                    humidity.modifier(CommonStyleModifier())
                    Spacer().frame(height: 16.5)
                    pressure.modifier(CommonStyleModifier())
                }
            }
        }
    }
    
    private var pollutionDetails: some View {
        VStack{
            Text(NSLocalizedString("airQuality", comment: "")).font(.title)
            HStack(alignment: .top){
                VStack{
                    Text(NSLocalizedString("usStd", comment: ""))
                    Text("\(city.pollution.aqiUsa, specifier: "%.0f") \(pollutionUnit(city.pollution.mainUsa))")
                }.modifier(CommonStyleModifier())
                Spacer().frame(width: 15)
                VStack{
                    Text(NSLocalizedString("chStd", comment: ""))
                    Text("\(city.pollution.aqiChina, specifier: "%.0f") \(pollutionUnit(city.pollution.mainChina))")
                }.modifier(CommonStyleModifier())
            }
        }
    }
    
    
    private var temperature: some View {
        VStack{
            Text(NSLocalizedString("temperature", comment: "")).font(.title3)
            temperture(city.weather.temperature, size: ViewSize.small)
        }
    }
    
    private var pressure: some View {
        VStack(){
            Text(NSLocalizedString("pressure", comment: "")).font(.title3)
            Text("\(city.weather.atmosphericPressure, specifier: "%.0f") hPa")
        }
    }
    
    private var wind: some View {
        VStack{
            Text(NSLocalizedString("wind", comment: "")).font(.title3)
            VStack(alignment: .leading){
                Text("\(NSLocalizedString("speed", comment: "")): \((city.weather.windSpeed * 3600) / 1000, specifier: "%.2f") km/h")
                windDirection(city.weather.windDirection, size: ViewSize.large)
            }
                windDirectionRose(city.weather.windDirection)
        }
    }
    private var humidity: some View {
        VStack {
            Text(NSLocalizedString("humidity", comment: "")).font(.title3)
            Text("\(city.weather.humidity, specifier: "%.0f") %")
        }
    }
}

struct CommonStyleModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .padding(10)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(colorScheme == .dark ? Color.darkTeal : Color.lightTeal)
            .cornerRadius(10)
            .shadow(radius: 10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )

    }
}


#Preview {
    DetailsWeatherView(city: WeatherViewModel(apiService: WeatherApiService()).cityList[1])
}
