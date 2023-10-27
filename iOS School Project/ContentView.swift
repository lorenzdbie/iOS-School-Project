//
//  ContentView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 27/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("GitHub-Logo")
                .resizable()
                .scaledToFit()
                .padding()
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, World")
            
            Text("this is the second commit")
                .font(.system(size: 50))
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
