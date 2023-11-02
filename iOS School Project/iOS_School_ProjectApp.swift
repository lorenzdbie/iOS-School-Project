//
//  iOS_School_ProjectApp.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 27/10/2023.
//

import SwiftUI

@main
struct iOS_School_ProjectApp: App {
    
    @ObservedObject var locationManager = LocationManager.shared
    var body: some Scene {
        WindowGroup {
            Group{
                let model = WeatherViewModel()
                
                if locationManager.userLocation == nil {
                    LocationRequestView()
                }else {
                    WeatherAppView(model: model).background(Color.black)
                }
            }
        }
    }
}
