//
//  Extentions.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 30/10/2023.
//
import SwiftUI
import Foundation

extension [WeatherCity]{
    func json() throws -> Data {
        let encoded = try JSONEncoder().encode(self)
        print("WeatherCity list = \(String(data: encoded, encoding: .utf8) ?? "nil")")
        return encoded
    }
    
    init(json: Data) throws {
        self = try JSONDecoder().decode([WeatherCity].self, from: json)
    }
}

extension Color {
    static let lightGray = Color(.sRGB, red: 211/255, green: 211/255, blue: 211/255, opacity: 1)
    static let lighterGray = Color(.sRGB, red: 240/255, green: 240/255, blue: 240/255, opacity: 1)
}

extension View {
    func gradientBackground(colorScheme: ColorScheme) -> some View {
        self.background(
            LinearGradient(
                stops: [
                    .init(color: colorScheme == .dark ? .teal : .white, location: 0),
                    .init(color: colorScheme == .dark ? .black : .teal, location: 0.6)
                ],
                startPoint: .bottom,
                endPoint: .top
            )
        )
    }
}
