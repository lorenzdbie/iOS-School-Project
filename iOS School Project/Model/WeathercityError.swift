//
//  WeathercityError.swift
//  iOS School Project
//
//  Created by Lorenz De Bie on 2/11/2023.
//

import Foundation

enum WeathercityError: Error, LocalizedError{
    case invalidURL
    case serverError
    case invalidData
    case unknown(Error)
    
    var errorDescription: String?{
        switch self {
        case .invalidURL:
            return "the URL was invalid, please try again later"
        case .serverError:
            return "There was an error with the server. Please try again later"
        case .invalidData:
            return "The weather data is invalid. Please try again later"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
