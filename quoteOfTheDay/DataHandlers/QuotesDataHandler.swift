//
//  DataHandler.swift
//  quoteOfTheDay
//
//  Created by Artem on 30/06/2023.
//

import SwiftUI


class DataHandler: DataSourceProtocol {
    private var manager = DataManager()
    
    func fetchQuotes(pickPage: String) async -> Quotes? {
        do {
            let fetchedQuotes: Quotes = try await manager.fetchData(url: "https://dummyjson.com/quotes/", page: pickPage)
            return fetchedQuotes
        } catch let error {
            print("error: \(error)")
            return nil
        }
    }
    
    func fetchQuote(withID id: String) async -> Quote? {
        do {
            let fetchedQuote: Quote = try await manager.fetchData(url: "https://dummyjson.com/quotes/", paramId: id)
            return fetchedQuote
        } catch let error {
            print("error: \(error)")
            return nil
        }
    }
}


