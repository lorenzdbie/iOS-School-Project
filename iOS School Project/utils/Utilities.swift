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

    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")


    if let date = dateFormatter.date(from: dateString) {
 
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"

        let formattedDateString = dateFormatter.string(from: date)

        return "\(formattedDateString)"
    } else {
        return dateString
    }
}
