//
//  DeatailWeatherView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import SwiftUI

struct DetailsWeatherView: View {
    
    let city: WeatherCity
    
    var body: some View {
        VStack{
            detailHeader
            HStack{
                VStack(alignment: .leading){
                    temperture(city.weather.temperature, size: ViewSize.large)
                    windDirection(city.weather.windDirection, size: ViewSize.large)
                    windDirectionRose(city.weather.windDirection)
                }
                Spacer()
                weatherIcon(city.weather.weatherIcon)
            }
            Spacer()
        }.padding(10)
    }

    private var detailHeader: some View{
        HStack(alignment: .firstTextBaseline){
            Text("Country: " + city.city.state.country.name)
            Spacer()
            Text("State: " + city.city.state.name)
            Spacer()
            Text("City: " + city.city.name)
        }.padding(.bottom, 10)
    }
}



#Preview {
    DetailsWeatherView(city: WeatherViewModel(apiService: WeatherApiService()).cityList[1])
}
