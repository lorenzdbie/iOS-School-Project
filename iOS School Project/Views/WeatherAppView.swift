//
//  ContentView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 27/10/2023.
//

import SwiftUI

struct WeatherAppView: View {
    @ObservedObject var model: WeatherViewModel
    @ObservedObject var loctionManager = LocationManager.shared
    @State public var isPopoverPresented: Bool = false
    @Environment(\.colorScheme) var colorScheme
    var textColor:Color { colorScheme == .dark ? .white : .black}
    var modeColor: Color { colorScheme == .dark ? .gray : .lightGray}
    
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
            if let location = loctionManager.userLocation{
                Text("Longitude = \(location.coordinate.longitude)")
                Text("Latitude = \(location.coordinate.latitude)")
            }
  
            List{
                NavigationLink(destination: DetailsWeatherView(city: model.cityList[0])){
                        Image(systemName: "location").font(.title2)
                        CityCard(city: model.cityList[0])
                }.deleteDisabled(true).moveDisabled(true)
                
                ForEach(model.cityList) { city in
                    NavigationLink(destination: DetailsWeatherView(city: city)) {
                        CityCard(city: city)
                    }
                }.onDelete{ indexSet in
                    withAnimation{
                        model.cityList.remove(atOffsets: indexSet)
                    }
                }
                .onMove { indexSet, newOffset in
                    model.cityList.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
            Spacer()
            addButton
        }
    
    }
    
    private var title: some View{
        HStack{
            Image("01n").resizable().scaledToFit()
            Text("Weather").font(.system(size: 50))
        }.frame(height: 50)//.padding(.bottom, 15)
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
            .popover(isPresented: $isPopoverPresented) {
                AddCityView(model: model, isShown: $isPopoverPresented).background(RoundedRectangle(cornerRadius: 40)
                    .opacity(0.3)).padding(10)
            }
            Spacer()
        }
    }
}


struct CityCard: View {
    let city: WeatherCity
    @State private var yOffset: CGFloat = 100 // Initial offset
    
    var body: some View {

        ZStack {
            HStack {
                Text(city.city.name).font(.title)/*.padding(.leading, 10)*/.lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                Spacer()
                tempCard(city.weather)
                weatherIcon(city.weather.weatherIcon).frame(height: 70)
            }
        }

        .offset(y: yOffset)
//        .onAppear {
//            withAnimation(.easeInOut(duration: 0.5)) {
//                yOffset = 0
//            }
        }
    }
    
    private func tempCard(_ weather: Weather)-> some View{
        VStack{
            temperture(weather.temperature, size: ViewSize.small).fontWeight(.light).font(.caption)
            Spacer().frame(height: getSystemFontSize())
            windDirection(weather.windDirection, size: ViewSize.small).fontWeight(.light).font(.caption)
        }.padding(.vertical, 15)
    }
}

#Preview {
    WeatherAppView(model: WeatherViewModel())
}
