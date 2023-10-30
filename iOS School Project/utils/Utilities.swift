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
