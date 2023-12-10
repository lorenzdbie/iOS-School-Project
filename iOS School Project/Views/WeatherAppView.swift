//
//  ContentView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 27/10/2023.
//

import SwiftUI

struct WeatherAppView: View {
    @ObservedObject var model: WeatherViewModel
    @State public var isPopoverPresented = false
    @State private var showAlert = false
    @Environment(\.colorScheme) var colorScheme
    var textColor:Color { colorScheme == .dark ? .white : .black}
    @State private var selection: WeatherCity?
    @State private var columnVisibility =
      NavigationSplitViewVisibility.doubleColumn
    
    var body: some View {
        VStack{
            title
            ViewThatFits{
                iPadView
                iPhoneView
            }
            .onReceive(model.$error, perform: { error in
                if error != nil {
                    showAlert.toggle()
                }
            }).alert(isPresented: $showAlert, content: {
                Alert(title:Text(NSLocalizedString("error", comment: "")),
                      message: Text(model.error?.localizedDescription ?? ""))
            })
        }.background(colorScheme == .dark ? .black : .teal)
    }
    
    var iPhoneView: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing){
                VStack {
                    iPhoneCityList
                        .refreshable {
                        model.handleRefresh()
                    }
                }
                addButton
            }
        }
    }
    
    var iPadView: some View{
        NavigationSplitView(columnVisibility: $columnVisibility){
            ZStack(alignment: .bottomTrailing){
                VStack {
                    iPadCityList
                        .refreshable {
                        model.handleRefresh()
                    }
                }
                addButton
            }
            .toolbar(removing: .sidebarToggle)
            .navigationSplitViewColumnWidth(1000)
        }
    detail: {
        if let city = selection {
            DetailsWeatherView(city: city)
        } else {
            VStack{
                Text("Select a city")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .gradientBackground(colorScheme: colorScheme)
    }
    }
     .navigationSplitViewStyle(.balanced)
}
    
    
    
    private var title: some View{
        HStack{
            let icon = model.localCity?.weather.weatherIcon ?? "01d"
            Image("\(icon)")
                .resizable()
                .scaledToFit()
            Text(NSLocalizedString("weather", comment: ""))
                .font(.system(size: 50))
        }.frame(height: 50)
    }
    
    
    
    private var iPadCityList: some View {
        List(selection: $selection ){
            if let localCity = model.localCity{
                NavigationLink(value: localCity){
                    Image(systemName: "location")
                        .font(.title2)
                    CityCard(city: localCity)
                }
            }
            ForEach(model.cityList) { city in
                NavigationLink(value: city) {
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
        .scrollContentBackground(.hidden)
            .gradientBackground(colorScheme: colorScheme)

    }
    
    
    
    private var iPhoneCityList: some View {
            List{
                if let localCity = model.localCity{
                    NavigationLink(destination: DetailsWeatherView(city: localCity)){
                        Image(systemName: "location")
                            .font(.title2)
                        CityCard(city: localCity)
                    }.deleteDisabled(true)
                        .moveDisabled(true)
                        .refreshable {
                            model.handleRefresh()
                        }
                }
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
            }.scrollContentBackground(.hidden)
            .gradientBackground(colorScheme: colorScheme)

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
                    .frame(width: 50, height: 50)
                    .background(Color.teal)
                    .foregroundStyle(colorScheme == .dark ? .black:.white)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }.padding(.bottom, 10)
                .popover(isPresented: $isPopoverPresented) {
                    AddCityView(model: model, isShown: $isPopoverPresented){
                        isPopoverPresented = false
                    }.background(RoundedRectangle(cornerRadius: 40)
                        .opacity(0.3)).padding(10)
                }
            Spacer()
        }
    }
}


struct CityCard: View {
    let city: WeatherCity
//    @State private var yOffset: CGFloat = 100 // Initial offset
    
    var body: some View {
        ZStack {
            HStack {
                Text(city.city.name).font(.title).lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                Spacer()
                tempCard(city.weather)
                weatherIcon(city.weather.weatherIcon).frame(height: 70)
            }
        }
        //       .offset(y: yOffset)
        //        .onAppear {
        //            withAnimation(.easeInOut(duration: 0.5)) {
        //                yOffset = 0
        //            }
        //       }
    }
    
    private func tempCard(_ weather: Weather) -> some View{
        VStack{
            temperture(weather.temperature, size: ViewSize.small).fontWeight(.light).font(.caption)
            Spacer().frame(height: getSystemFontSize())
            windDirection(weather.windDirection, size: ViewSize.small).fontWeight(.light).font(.caption)
        }.padding(.vertical, 15)
    }
}

#Preview {
    WeatherAppView(model: WeatherViewModel(apiService: WeatherApiService()))
}
