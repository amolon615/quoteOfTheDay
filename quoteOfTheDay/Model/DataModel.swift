//
//  DataModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

//Quotes Object
struct Quotes: Codable, Hashable {
    let quotes: [Quote]
    let total, skip, limit: Int
    
}

//Quote object
struct Quote: Codable, Identifiable, Hashable {
    let id: Int
    let quote, author: String
}

//Errors 
enum QuoteLoadingError: Error {
    case badUrl
    case badResponse
    case badDecoding
}

enum ImageLoadingError: Error {
    case badUrl
    case badResponse
    case badDecoding
}



//image
struct Images: Codable {
    let page, perPage: Int
    let photos: [Photo]?
    let nextPage: String
}

struct Photo: Codable {
    let id, width, height: Int
    let url: String
    let photographer: String?
    let photographerURL: String?
    let photographerID: Int?
    let avgColor: String
    let src: Src
    let liked: Bool
    let alt: String
}

struct Src: Codable {
    let original, large2X, large, medium: String?
    let small, portrait, landscape, tiny: String?
}
