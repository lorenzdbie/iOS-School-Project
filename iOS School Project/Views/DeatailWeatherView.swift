//
//  DeatailWeatherView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import SwiftUI

struct DeatailWeatherView: View {
    
    let city: WeatherCity
    
    var body: some View {
        VStack{
            detailHeader
            HStack{
                VStack(alignment: .leading){
                    Text("Temperature: \(city.weather.temperature, specifier: "%.1f")°C")
                    windDirection(city.weather.windDirection, size:"large")
                    windDirectionRose(city.weather.windDirection)
                }
                Spacer()
            }
            Spacer()
        }.padding(10)
    }

    
    private var detailHeader: some View{
        HStack(alignment: .firstTextBaseline){
            Text("Country: " + city.country)
            Spacer()
            Text("State: " + city.state)
            Spacer()
            Text("City: " + city.city)
        }.padding(.bottom, 10)
    }
}


private func windDirectionRose(_ windDirection: Float) -> some View{
    Image("compass")
        .resizable()
        .aspectRatio(1, contentMode:.fit)
        .padding(EdgeInsets(top: -34, leading: -36, bottom: -38,  trailing: -36))
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        .scaledToFit()
        .frame(width: 100)
        .rotationEffect(Angle(degrees: Double(windDirection - 32)), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
}


func windDirection(_ directionFloat: Float, size :String) ->  some View{
    var direction:String {
        if directionFloat >= 22.5 && directionFloat < 67.5 {
            return "North East"
        } else if directionFloat >= 67.5 && directionFloat < 112.5 {
            return "East"
        } else if directionFloat >= 112.5 && directionFloat < 157.5 {
            return "South East"
        } else if directionFloat >= 157.5 && directionFloat < 202.5 {
            return "South"
        } else if directionFloat >= 202.5 && directionFloat < 247.5 {
            return "South West"
        }else if directionFloat >= 247.5 && directionFloat < 292.5 {
            return "West"
        } else if directionFloat >= 292.5 && directionFloat < 337.5 {
            return "North West"
        } else {
            return "North"
        }
    }
    if size == "small"{
        var short: String = ""
        for letter in direction {
            if letter >= "A" && letter <= "Z"{
                short += String(letter)
            }
        }
        return Text(short)
    }else{
       return  Text("Wind direction: " + direction)
    }
}

#Preview {
    DeatailWeatherView(city: WeatherViewModel().cityList[1])
}
