//
//  LocationRequestView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 1/11/2023.
//

import SwiftUI

struct LocationRequestView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack{
            Color(.clear).gradientBackground(colorScheme: colorScheme).ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Image(systemName: "paperplane.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    
                    .padding(.bottom, 32)
                
                Text(NSLocalizedString("startSharingTitle", comment: ""))
                    .font(.system(size: 28, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text(NSLocalizedString("startSharing", comment: ""))
                    .multilineTextAlignment(.center)
                    .frame(width: 140)
                    .padding()
                
                Spacer()
                
                VStack{
                    Button{
                        print("request location from user")
                        LocationManager.shared.requestLocation()
                    } label: {
                        Text(NSLocalizedString("allow", comment: ""))
                            .padding()
                            .font(.headline)
                            .foregroundColor(colorScheme == .dark ? .darkTeal: .white)
                    }.frame(minWidth: 200, maxWidth: 500, alignment: .center)
                        .padding(.horizontal, -32)
                        .background(colorScheme == .dark ? .white : .darkTeal)
                        .clipShape(Capsule())
                        .shadow(radius: 10)
                        .padding()
                    
                    Button{
                        print("Dismiss")
                        LocationManager.shared.dismissLocation()
                    } label: {
                        Text(NSLocalizedString("dismiss", comment: ""))
                            .padding()
                            .font(.headline)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }.padding(.bottom, 32)
            }
        }
    }
}

#Preview {
    LocationRequestView()
}
