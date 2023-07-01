//
//  DataSourceProtocol.swift
//  quoteOfTheDay
//
//  Created by Artem on 01/07/2023.
//

import Foundation

protocol DataSourceProtocol: AnyObject {
    func fetchQuotes(pickPage: String) async -> Quotes?
    func fetchQuote(withID id: String) async -> Quote?
}
