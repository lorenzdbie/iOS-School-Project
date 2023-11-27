//
//  Utilities.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 29/10/2023.
//

import Foundation
import SwiftUI

enum ViewSize{
    case small, large
}

func getSystemFontSize()-> CGFloat{
    return UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
}

func convertDateString(_ dateString: String) -> String {
    // Create a DateFormatter instance
    let dateFormatter = DateFormatter()

    // Set the input format
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

    // Convert the string to a Date object
    if let date = dateFormatter.date(from: dateString) {
        // Set the desired output format
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"

        // Convert the Date object to a string in the desired format
        let formattedDateString = dateFormatter.string(from: date)

        return "\(formattedDateString)"
    } else {
        return dateString
    }
}
