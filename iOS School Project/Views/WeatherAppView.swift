//
//  ContentView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 27/10/2023.
//

import SwiftUI

struct WeatherAppView: View {
    
    @ObservedObject var model: WeatherViewModel
    @State var active: Bool = false
    @Environment(\.colorScheme) var colorScheme
    var modeColor: Color { colorScheme == .dark ? .gray : .gray}
    
    var body: some View {
            VStack {
                title
                ForEach(model.cityList){ city in
                    cityCard(city: city, modeColor: modeColor)
                }
            }.padding(5)
            Spacer()
        }
    
    var title: some View{
        HStack{
            Image("01n").resizable().scaledToFit()
            Text("Weather").font(.system(size: 50))
        }.frame(height: 50).padding(.bottom, 15)
    }
}


struct cityCard: View{
    let city: WeatherCity
    let modeColor: Color
    
    var body: some View{
        let background = RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.accentColor)
            .opacity(0.3)
        
        ZStack{
            HStack{
                Text(city.city.name)
                    .font(.title)
                    .padding(.leading, 10)
                Spacer()
                tempCard(city.weather)
                weatherIcon(city.weather.weatherIcon)
            }.background(RoundedRectangle(cornerRadius: 15.0)
                .foregroundColor(modeColor))
            .padding(1)
        }.background(background)
            .frame(height: 70)
    }
    
    private func tempCard(_ weather: Weather)-> some View{
        VStack{
            temperture(weather.temperature, size: ViewSize.small).fontWeight(.light).font(.caption)
         Spacer()
            windDirection(weather.windDirection, size: ViewSize.small).padding(.bottom, 10)
        }.padding(.top, 15)
    }
}








#Preview {
    WeatherAppView(model: WeatherViewModel())
}
