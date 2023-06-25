//
//  ImageLoadingManager.swift
//  quoteOfTheDay
//
//  Created by Artem on 24/06/2023.
//

import SwiftUI

//images loader
class ImageLoader {
    private let apiKey = "glKsVgw88BD3exwfg9f5DYoUfEcxC0gPj4ykmYNdED98h1wFL8DgmLbA"
    
    func loadImage() async throws -> Images? {
        guard let url = URL(string: "https://api.pexels.com/v1/curated?per_page=60") else {
            throw ImageLoadingError.badUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let headers = [
            "Authorization": "\(apiKey)",
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
