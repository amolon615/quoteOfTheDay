//
//  QuotesViewModelMockData.swift
//  quoteOfTheDay
//
//  Created by Artem on 01/07/2023.
//

import SwiftUI

class MockDataSource: DataSourceProtocol {
    func fetchQuotes(pickPage: String) async -> Quotes? {
        do {
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000)  // Sleep for 5 seconds (5 * 1 billion nanoseconds)
        } catch let error {
            print("error: \(error)")
        }
        let quotesToTest = [
            Quote(id: 1, quote: "First", author: "Artem"),
            Quote(id: 2, quote: "Second", author: "Lena"),
            Quote(id: 3, quote: "Third", author: "Alice")
        ]
        let QuoteTest = Quotes(quotes: quotesToTest, total: 10, skip: 0, limit: 3)
        return QuoteTest
    }
    
    
    func fetchQuote(withID id: String) async -> Quote? {
        do {
            try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        } catch let error {
            print("error: \(error)")
        }
        let quoteToTest = Quote(id: 1, quote: "testQuote", author: "testAuthor")
        return quoteToTest
    }
}
