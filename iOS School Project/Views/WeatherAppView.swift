//
//  ContentView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 27/10/2023.
//

import SwiftUI

struct WeatherAppView: View {
    
    @ObservedObject var model: WeatherViewModel
    @Environment(\.colorScheme) var colorScheme
    private var modeColor: Color { colorScheme == .dark ? .black : .white}
    
    var body: some View {
        VStack {
            title
            ForEach(model.cityList){ city in
                cityCard(city)
            }
        }.padding(5)
        Spacer()
    }
    
    var title: some View{
        HStack{
            Image("01n").resizable().scaledToFit()
            Text("Weather").font(.largeTitle)
        }.frame(height: 50)
    }
    
    @ViewBuilder
    func cityCard(_ city: WeatherCity) -> some View{
        let background = RoundedRectangle(cornerRadius: 20).foregroundColor(.accentColor).opacity(0.3)
        ZStack{
            HStack{
                Text(city.city).font(.title).padding(.leading, 10)
                Spacer()
                tempCard(city.weather.temperature)
                Image(city.weather.weatherIcon).resizable().scaledToFit().padding(5)
            }.background(RoundedRectangle(cornerRadius: 20.0).foregroundColor(modeColor)).padding(1)
        }.background(background).frame(height: 70)
    }
    
    func tempCard(_ temp: Float)-> some View{
        VStack{
            Text("\(temp, specifier: "%.1f")°C").fontWeight(.light).font(.caption)
            Spacer()
        }.padding(.top, 15)
    }
    }



#Preview {
    WeatherAppView(model: WeatherViewModel())
}
