//
//  DataModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI



//------------------Quotes-Start----------------------//

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
//------------------Quotes-End----------------------//

//------------------Errors-Start----------------------//

//Quote errors
enum QuoteLoadingError: Error {
    case badUrl
    case badResponse
    case badDecoding
    case badLoading
}
//Image errors
enum ImageLoadingError: Error {
    case badUrl
    case badResponse
    case badDecoding
}

//------------------Errors-End----------------------//


//------------------Images-Start----------------------//
//image data structures
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

//------------------Images-End----------------------//
