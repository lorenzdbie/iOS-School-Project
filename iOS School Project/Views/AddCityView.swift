//
//  AddCityView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import SwiftUI


struct AddCityView: View {
    var model: WeatherViewModel
    @Binding var isShown: Bool
    
    @State private var selectedCountry: String = ""
    @State private var selectedState: String = ""
    @State private var selectedCity: String = ""
    
    var body: some View {
        title
        Selector(title: "Country", items: model.locationProvider.getCountries(), selectedItem: $selectedCountry)
        if !selectedCountry.isEmpty {
            Selector(title: "State", items: model.locationProvider.getStates(country: selectedCountry) ?? [], selectedItem: $selectedState)
        }
        if !selectedState.isEmpty {
            Selector(title: "City", items: model.locationProvider.getCities(country: selectedCountry, state: selectedState) ?? [], selectedItem: $selectedCity)
        }
        Spacer()
        addButton
        Spacer().frame(height: 30)
    }
    
    private var title: some View {
        HStack{
            Text("Add a new city").font(.system(size: 40))
            Spacer()
            closeButton
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 50, trailing: 20))
    }
    
    private var addButton: some View{
        HStack{
            Spacer()
            Button(action: {
                // Handle add city action
            }, label: {
                Text("Add city").font(.largeTitle)
            }).disabled(selectedCountry.isEmpty || selectedState.isEmpty || selectedCity.isEmpty)
            Spacer()
        }
    }
    
    private var closeButton: some View{
        Button(action:{
            isShown.toggle()
        },label: {
            Image(systemName: "xmark.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                //.foregroundColor(.blue)
        })
    }
}


struct Selector<T: Hashable>: View {
    var title: String
    var items: [String]
    @Binding var selectedItem: T
    
    var body: some View {
        HStack{
            Text("\(title): ")
               Spacer()
            Picker(title, selection: $selectedItem) {
                Text("Select ... ").tag("")
                ForEach(items, id: \.self) { item in
                    Text("\(item)")
                }
            }
        }
        .padding(.horizontal, 20)
    }
}


//struct AddCityView: View {
//    
//    var model: WeatherViewModel
//    
//    @State var selectedCountry: String = ""
//    @State var selectedState: String = ""
//    @State var selectedCity: String = ""
//    
//    var body: some View {
//        title
//        selector
//        Spacer()
//    }
//    
//    private var title: some View {
//        Text("Add a new city").font(.system(size: 50)).padding(.bottom, 50)
//    }
//    
//    private var selector: some View {
//        VStack(alignment:.leading) {
//            HStack {
//                Text("Country: ")
//                Spacer()
//                Picker("Country", selection: $selectedCountry) {
//                    if selectedCountry.isEmpty{
//                        Text("Select ... ").tag("")
//                    }
//                    ForEach(model.locationProvider.getCountries(), id: \.self) { country in
//                        Text(country)
//                    }
//                }
//            }
//            if !selectedCountry.isEmpty {
//                HStack {
//                    Text("State: ")
//                    Spacer()
//                    Picker("State", selection: $selectedState) {
//                        if selectedState.isEmpty{
//                            Text("Select ... ").tag("")
//                        }
//                        ForEach(model.locationProvider.getStates(country: selectedCountry) ?? [], id: \.self) { state in
//                            Text(state)
//                        }
//                    }
//                }
//            }
//            if !selectedState.isEmpty {
//                HStack {
//                    Text("City: ")
//                    Spacer()
//                    Picker("City", selection: $selectedCity) {
//                        if selectedCity.isEmpty{
//                            Text("Select ... ").tag("")
//                        }
//                        ForEach(model.locationProvider.getCities(country: selectedCountry, state: selectedState) ?? [], id: \.self) { city in
//                            Text(city)
//                        }
//                    }
//                }
//            }
//            Spacer()
//            HStack {
//                Spacer()
//                Button(action: {
//                    // Handle add city action
//                }, label: {
//                    Text("Add city")
//                }).disabled(selectedCountry.isEmpty || selectedState.isEmpty || selectedCity.isEmpty)
//                Spacer()
//            }
//            Spacer().frame(height: 30)
//        }.padding(.horizontal, 30)
//    }
//}



//#Preview {
//    AddCityView(model: WeatherViewModel())
//}

