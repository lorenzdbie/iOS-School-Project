//
//  AddCityView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import SwiftUI


struct AddCityView: View {
    @ObservedObject var model: WeatherViewModel
    @ObservedObject var addCityViewModel = AddCityViewModel(apiService: WeatherApiService())
    @Binding var isShown: Bool
    var onAddCity: ()-> Void
    
    @State private var selectedCountry: String = ""
    @State private var selectedState: String = ""
    @State private var selectedCity: String = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack{
            title
            selector
            Spacer()
            addButton
            Spacer().frame(height: 30)
        }.frame(height: 400)
            .onChange(of: selectedCountry) {
                addCityViewModel.getStatesForCountry(country: selectedCountry)
            }
            .onChange(of: selectedState) {
                addCityViewModel.getCitiesForState(state: selectedState)
            }.onReceive(addCityViewModel.$error, perform: { error in
                if error != nil {
                    showAlert.toggle()
                }
            }).alert(isPresented: $showAlert, content: {
                Alert(title:Text(NSLocalizedString("error", comment: "")),
                      message: Text(addCityViewModel.error?.localizedDescription ?? ""))
            })
    }
    
    private var selector: some View {
        VStack(alignment:.leading) {
            HStack {
                Text("\(NSLocalizedString("country", comment: "")): ").padding(10)
                Spacer()
                if addCityViewModel.countries.isEmpty{
                    Text("\(NSLocalizedString("loading", comment: ""))...").padding(10)
                }else{
                    Picker(NSLocalizedString("country", comment: ""), selection: $selectedCountry) {
                        
                        if selectedCountry.isEmpty{
                            Text("\(NSLocalizedString("select", comment: ""))...").tag("")
                        }
                        ForEach(addCityViewModel.countries, id: \.self) { country in
                            Text(country.country).tag(country.country)
                        }
                    }
                }
            }
            if !selectedCountry.isEmpty{
                
                HStack {
                    Text("\(NSLocalizedString("state", comment: "")): ").padding(10)
                    Spacer()
                    if addCityViewModel.states.isEmpty{
                        Text("\(NSLocalizedString("loading", comment: ""))...").padding(10)
                    } else{
                        Picker(NSLocalizedString("state", comment: ""), selection: $selectedState) {
                            
                            if selectedState.isEmpty{
                                Text("\(NSLocalizedString("select", comment: ""))...").tag("")
                            }
                            ForEach(addCityViewModel.states, id: \.self) { state in
                                Text(state.state).tag(state.state)
                            }
                        }
                    }
                }
            }
            if !selectedState.isEmpty {
                HStack {
                    Text("\(NSLocalizedString("city", comment: "")): ").padding(10)
                    Spacer()
                    if addCityViewModel.cities.isEmpty {
                        Text("\(NSLocalizedString("loading", comment: ""))...").padding(10)
                    } else {
                        Picker(NSLocalizedString("city", comment: ""), selection: $selectedCity) {
                            
                            if selectedCity.isEmpty{
                                Text("\(NSLocalizedString("select", comment: ""))...").tag("")
                            }
                            ForEach(addCityViewModel.cities, id: \.self) { city in
                                Text(city.city).tag(city.city)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    private var title: some View {
        HStack{
            Text(NSLocalizedString("addNewCity", comment: "")).font(.largeTitle)
            Spacer()
            closeButton
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 50, trailing: 20))
    }
    
    private var addButton: some View{
        HStack{
            Spacer()
            Button(action: {
                model.addCity(country: selectedCountry, state: selectedState, city: selectedCity)
                onAddCity()
            }, label: {
                Text(NSLocalizedString("addCity", comment: "")).font(.largeTitle)
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
        })
    }
}


//struct Selector<T: Hashable>: View {
//    var title: String
//    var items: [String]
//    @Binding var selectedItem: T
//    
//    var body: some View {
//        HStack{
//            Text("\(title): ")
//            Spacer()
//            Picker(title, selection: $selectedItem) {
//                Text("Select ... ").tag("")
//                ForEach(items, id: \.self) { item in
//                    Text("\(item)")
//                }
//            }
//        }
//        .padding(.horizontal, 20)
//    }
//}
