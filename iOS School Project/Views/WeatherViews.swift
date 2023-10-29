//
//  WeatherViews.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import SwiftUI


func temperture(_ temp: Float, size: ViewSize) -> some View{
    if size == ViewSize.small {
        return Text("\(temp, specifier: "%.1f")°C")
    } else {
        return Text("Temperature: \(temp, specifier: "%.1f")°C")
    }
}


func weatherIcon(_ icon: String)-> some View{
    Image(icon).resizable().scaledToFit().padding(5)
}


func windDirectionRose(_ windDirection: Float) -> some View{
    HStack{
        Spacer()
        Image("compass")
            .resizable()
            .aspectRatio(1, contentMode:.fit)
            .padding(EdgeInsets(top: -34, leading: -36, bottom: -38,  trailing: -36))
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .scaledToFit()
            .frame(width: 100)
            .rotationEffect(Angle(degrees: Double(windDirection - 32)), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        Spacer()
    }
}


func windDirection(_ directionFloat: Float, size : ViewSize) ->  some View{
    let direction = directionBasedOnDegrees(directionFloat)
    return Text(size == ViewSize.small ? shortNotation(direction) : "Wind direction: " + direction)
}


private func directionBasedOnDegrees(_ direction: Float) -> String{
        if direction >= 22.5 && direction < 67.5 { return "North East" }
        else if direction >= 67.5 && direction < 112.5 { return "East" }
        else if direction >= 112.5 && direction < 157.5 { return "South East"}
        else if direction >= 157.5 && direction < 202.5 { return "South" }
        else if direction >= 202.5 && direction < 247.5 { return "South West" }
        else if direction >= 247.5 && direction < 292.5 { return "West" }
        else if direction >= 292.5 && direction < 337.5 { return "North West" }
        else { return "North" }
}


private func shortNotation(_ direction: String) -> String {
    var short: String = ""
    for letter in direction {
        if letter >= "A" && letter <= "Z"{
            short += String(letter)
        }
    }
        return short
    }

