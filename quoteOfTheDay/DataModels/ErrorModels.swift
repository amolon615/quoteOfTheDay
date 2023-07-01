//
//  DataModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

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

