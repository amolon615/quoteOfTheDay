//
//  Quotes.swift
//  quoteOfTheDay
//
//  Created by Artem on 29/06/2023.
//

import Foundation

//Quotes Object
struct Quotes: Codable, Hashable {
    let quotes: [Quote]
    let total, skip, limit: Int
}

