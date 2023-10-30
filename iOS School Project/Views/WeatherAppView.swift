//
//  ContentView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 27/10/2023.
//

import SwiftUI

struct WeatherAppView: View {
    @ObservedObject var model: WeatherViewModel
    @State public var isPopoverPresented: Bool = false
    @Environment(\.colorScheme) var colorScheme
    var modeColor: Color { colorScheme == .dark ? .gray : .gray}
    
    var body: some View {
        NavigationView {
           mainView
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .background(NavigationLink("", destination: EmptyView()).opacity(0))
        }

    
    
    private var mainView: some View{
        VStack {
            title
            ForEach(model.cityList) { city in
                NavigationLink(destination: DetailsWeatherView(city: city)) {
                    CityCard(city: city, modeColor: modeColor)
                }
            }
            Spacer()
            addButton
        }
        .padding(5)
    }
    
    private var title: some View{
        HStack{
            Image("01n").resizable().scaledToFit()
            Text("Weather").font(.system(size: 50))
        }.frame(height: 50).padding(.bottom, 15)
    }
    
    private var addButton: some View{
        HStack{
            Spacer()
            Button(action: {
                isPopoverPresented.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundColor(modeColor)
                    .padding(20)
            }
            .sheet(isPresented: $isPopoverPresented) {
                AddCityView(model: model, isShown: $isPopoverPresented).background(RoundedRectangle(cornerRadius: 30)
                    .opacity(0.3)).padding(20)
            }
            Spacer()
        }
    }
}
    

struct CityCard: View {
    let city: WeatherCity
    let modeColor: Color
    @State private var yOffset: CGFloat = 50 // Initial offset
    
    var body: some View {
        let background = RoundedRectangle(cornerRadius: 15)
            .foregroundColor(.accentColor).opacity(0.3)
        
        ZStack {
            HStack {
                Text(city.city.name).font(.title).padding(.leading, 10)
                Spacer()
                tempCard(city.weather)
                weatherIcon(city.weather.weatherIcon)
            }
            .background(RoundedRectangle(cornerRadius: 15.0).foregroundColor(modeColor)).padding(1)
        }
        .background(background).frame(height: 70)
        .offset(y: yOffset)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                yOffset = 0
            }
        }
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
