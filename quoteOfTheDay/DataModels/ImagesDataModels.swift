//
//  ImagesDataModels.swift
//  quoteOfTheDay
//
//  Created by Artem on 29/06/2023.
//

import Foundation


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
