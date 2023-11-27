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
        return Text("\(NSLocalizedString("temperature", comment: "")): \(temp, specifier: "%.1f")°C")
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
    return Text(size == ViewSize.small ? shortNotation(direction) : "\(NSLocalizedString("windDirection", comment: "")): \n" + direction)
}


private func directionBasedOnDegrees(_ direction: Float) -> String{
    if direction >= 11.25 && direction < 33.75 { return NSLocalizedString("NNE", comment: "") }
    else if direction >= 33.75 && direction < 56.25 { return NSLocalizedString("NE", comment: "") }
    else if direction >= 56.25 && direction < 78.75 { return NSLocalizedString("ENE", comment: "") }
    else if direction >= 78.75 && direction < 101.25 { return NSLocalizedString("E", comment: "") }
    else if direction >= 101.25 && direction < 123.75 { return NSLocalizedString("ESE", comment: "")}
    else if direction >= 123.75 && direction < 146.25 { return NSLocalizedString("SE", comment: "")}
    else if direction >= 146.25 && direction < 168.75 { return NSLocalizedString("SSE", comment: "")}
    else if direction >= 168.75 && direction < 191.25 { return NSLocalizedString("S", comment: "") }
    else if direction >= 191.25 && direction < 213.75 { return NSLocalizedString("SSW", comment: "") }
    else if direction >= 213.75 && direction < 236.25 { return NSLocalizedString("SW", comment: "") }
    else if direction >= 236.25 && direction < 258.75 { return NSLocalizedString("WSW", comment: "") }
    else if direction >= 258.75 && direction < 281.25 { return NSLocalizedString("W", comment: "") }
    else if direction >= 281.25 && direction < 303.75 { return NSLocalizedString("WNW", comment: "") }
    else if direction >= 303.75 && direction < 326.25 { return NSLocalizedString("NW", comment: "") }
    else if direction >= 326.25 && direction < 348.75 { return NSLocalizedString("NNW", comment: "") }
        else { return NSLocalizedString("N", comment: "") }
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


func pollutionUnit(_ unit: String) -> String{
    return switch unit {
    case "p1" : "ug/m3"  //pm10
    case "p2" : "ug/m3" //pm2.5
    case "o3": "ppb 03" //Ozone O3
    case "n2": "ppb NO2" //Nitrogen dioxide NO2
    case "s2": "ppb SO2" //Sulfur dioxide SO2
    case "co": "ppm CO" //Carbon monoxide CO
    default: ""
 
    }
}
