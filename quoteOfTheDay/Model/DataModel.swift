//
//  DataModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

//Quotes Object
struct Quotes: Codable {
    let quotes: [Quote]
    let total, skip, limit: Int
}

//Quote object
struct Quote: Codable, Identifiable {
    let id: Int
    let quote, author: String
}

//Errors 
enum QuoteLoadingError: Error {
    case badUrl
    case badResponse
    case badDecoding
}
