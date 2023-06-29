//
//  QuoteDataModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 29/06/2023.
//

import Foundation


//Quote object
struct Quote: Codable, Identifiable, Hashable {
    let id: Int
    let quote, author: String
}
