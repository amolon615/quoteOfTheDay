//
//  NetworkingManager.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

//Quotes data manager
class DataManager {
    //generic method for fetching data. url is building during the call adding paramId, page number or limit for objects per page.
    func fetchData <T: Codable> (url: String, paramId: String = "", page: String = "") async throws -> T {
        //checking URL
        guard let url = URL(string: url + paramId + page) else {
            throw QuoteLoadingError.badUrl
        }
        let session = URLSession(configuration: .default)
        
        //handling server response & fetching raw data
        let (data, response) = try await session.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw QuoteLoadingError.badResponse
        }
        do {
            //parsing data
            let fetchedData = try JSONDecoder().decode(T.self, from: data)
            return fetchedData
        } catch {
            throw QuoteLoadingError.badDecoding
        }
    }
}


