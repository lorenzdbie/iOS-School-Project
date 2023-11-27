//
//  LocationRequestView.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 1/11/2023.
//

import SwiftUI

struct LocationRequestView: View {
    var body: some View {
        ZStack{
            Color(.blue).ignoresSafeArea()
            
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
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }.frame(width: UIScreen.main.bounds.width)
                        .padding(.horizontal, -32)
                        .background(.white)
                        .clipShape(Capsule())
                        .padding()
                    
                    Button{
                        print("Dismiss")
                        LocationManager.shared.dismissLocation()
                    } label: {
                        Text(NSLocalizedString("dismiss", comment: ""))
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }.padding(.bottom, 32)
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    LocationRequestView()
}
