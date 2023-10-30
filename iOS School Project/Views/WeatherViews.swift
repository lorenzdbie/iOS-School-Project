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
    if direction >= 11.25 && direction < 33.75 { return "North North East" }
    else if direction >= 33.75 && direction < 56.25 { return "North East" }
    else if direction >= 56.25 && direction < 78.75 { return "East North East" }
    else if direction >= 78.75 && direction < 101.25 { return "East" }
    else if direction >= 101.25 && direction < 123.75 { return "East South East"}
    else if direction >= 123.75 && direction < 146.25 { return "South East"}
    else if direction >= 146.25 && direction < 168.75 { return "South South East"}
    else if direction >= 168.75 && direction < 191.25 { return "South" }
    else if direction >= 191.25 && direction < 213.75 { return "South South West" }
    else if direction >= 213.75 && direction < 236.25 { return "South West" }
    else if direction >= 236.25 && direction < 258.75 { return "West South West" }
    else if direction >= 258.75 && direction < 281.25 { return "West" }
    else if direction >= 281.25 && direction < 303.75 { return "West North West" }
    else if direction >= 303.75 && direction < 326.25 { return "North West" }
    else if direction >= 326.25 && direction < 348.75 { return "North North West" }
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

