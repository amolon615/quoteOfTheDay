//
//  NetworkingManager.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import Foundation


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
