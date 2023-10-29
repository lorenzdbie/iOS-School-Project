//
//  AddCityView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import SwiftUI

struct AddCityView: View {
    
    var model: WeatherViewModel
    
    @State var countySelected: Bool = true
    @State var stateSelected: Bool = true
    @State var citySelected: Bool = true
    
    var body: some View {
        title
        Spacer()
        selector
        Spacer()
    }
    
    private var title: some View{
        Text("Add a new city").font(.system(size: 50)).padding(.bottom, 15)
    }
    
    private var selector: some View{
        VStack(alignment:.leading){
            HStack{
                Text("select Country: ")
                Spacer()
            }
            if (countySelected){
                HStack{
                    Text("select state: ")
                }
            }
            if (countySelected && stateSelected){
                HStack{
                    Text("select city: ")
                }
            }
            Spacer().frame(height: 30)
            HStack{
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Add city")
                }).disabled(!(citySelected && stateSelected && citySelected))
                Spacer()
            }
        }.padding(.leading, 30)
    }
}

#Preview {
    AddCityView(model: WeatherViewModel())
}

