//
//  NetworkingManager.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import Foundation
import SwiftUI

//quotes loader
class DataManager {
    //generic method for fetching data. url is building during the call adding paramId, page number or limit for objects per page.
    func fetchData <T: Codable> (url: String, paramId: String = "", page: String = "", limit: String = "") async throws -> T {
        guard let url = URL(string: url + paramId + page + limit) else {
            throw QuoteLoadingError.badUrl
        }
        print(url)
        let session = URLSession(configuration: .default)
        let (data, response) = try await session.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw QuoteLoadingError.badResponse
        }
        do {
            let fetchedQuotes = try JSONDecoder().decode(T.self, from: data)
            return fetchedQuotes
        } catch {
            throw QuoteLoadingError.badDecoding
        }
    }
}

//images loader
class ImageLoader {
    let apiKey = "glKsVgw88BD3exwfg9f5DYoUfEcxC0gPj4ykmYNdED98h1wFL8DgmLbA"
    
    func loadImage() async throws -> Images? {
        
        guard let url = URL(string: "https://api.pexels.com/v1/curated?per_page=60") else {
            print("bad error")
            throw ImageLoadingError.badUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let headers = [
            "Authorization": "glKsVgw88BD3exwfg9f5DYoUfEcxC0gPj4ykmYNdED98h1wFL8DgmLbA",
            "X-RapidAPI-Host": "PexelsdimasV1.p.rapidapi.com"
        ]
        request.allHTTPHeaderFields = headers
        
        
        let session = URLSession(configuration: .default)
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
                else {
                throw ImageLoadingError.badResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let fetchedImages = try decoder.decode(Images.self, from: data)
            return fetchedImages
        } catch let error {
            print("Error decoding images: \(error)")
            return nil
        }
    }
}
