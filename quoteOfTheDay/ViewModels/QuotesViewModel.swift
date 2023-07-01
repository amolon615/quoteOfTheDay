//
//  QuoteViewModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

protocol DataSourceProtocol: AnyObject {
    func fetchQuotes(pickPage: String) async -> Quotes?
    func fetchQuote(withID id: String) async -> Quote?
}

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


class MockDataSourceProtocol: DataSourceProtocol {
    func fetchQuotes(pickPage: String) async -> Quotes? {
        do {
            try await Task.sleep(nanoseconds: 5 * 1_000_000_000)  // Sleep for 5 seconds (5 * 1 billion nanoseconds)
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
            try await Task.sleep(nanoseconds: 5 * 1_000_000_000)
        } catch let error {
            print("error: \(error)")
        }
        let quoteToTest = Quote(id: 1, quote: "testQuote", author: "testAuthor")
        return quoteToTest
    }
}





class QuotesViewModel: ObservableObject {
    
    private var router = Router()
    //data objects
    @Published var quotes: Quotes? = nil
    @Published var quote: Quote? = nil
    
    @Published var quotesList: [Quote]  = []
    
    //error handling
    @Published var errorTitle: String? = nil
    @Published var errorImage: String? = nil
    @Published var errorSolution: String? = nil
    
    @Published var retryButtonShow: Bool = true
    
    //page controls
    @Published var pageNumb: Int = 0
    @Published var limitNub: Int = 10
    @Published var currentPage: Int = 0
    
    //quotes state for controlling loader view and perform load ops
    @Published var quotesDidLoad: Bool = false
    
    
    //switch pages, constructing our URL
    
    func loadQuotes(dataHandler: DataSourceProtocol = DataHandler() ) {
        let dataHandler = dataHandler
        Task {
            let fetchdQuotesList = await dataHandler.fetchQuotes(pickPage: self.pickPage())
            guard let fetchdQuotesListUnwrapped = fetchdQuotesList else { return }
            DispatchQueue.main.async {
                self.quotesList = fetchdQuotesListUnwrapped.quotes
            }
        }
    }
    
    func loadQuote(dataHandler: DataSourceProtocol = DataHandler() , withID id: String) {
        let dataHandler = dataHandler
        Task {
            let fetchedQuote = await dataHandler.fetchQuote(withID: id)
            guard let fetchedQuoteUnwrapped = fetchedQuote else { return }
            DispatchQueue.main.async {
                self.quote = fetchedQuoteUnwrapped
            }
        }
    }
    
    func pickPage() -> String {
        let skipValue = quotesList.count
        DispatchQueue.main.async {
            self.currentPage += 1
        }
        return "?skip=\(skipValue)"
    }
    
    private func handleFetchDataError(_ error: Error) {
        if let quoteLoadingError = error as? QuoteLoadingError {
            switch quoteLoadingError {
            case .badUrl:
                self.errorTitle = "Bad URL"
                self.errorSolution = "Check URL and re-try."
                self.errorImage = "unicorn_black"
                self.retryButtonShow = false
            case .badResponse:
                self.errorTitle = "Bad Server Response."
                self.errorSolution = "Server issues. It has nothing to do with you :)"
                self.errorImage = "astronaut"
                self.retryButtonShow = true
            case .badDecoding:
                self.errorTitle = "Bad Decoding."
                self.errorSolution = "Contact developer to check data-models types & structure."
                self.errorImage = "unicorn_black"
                self.retryButtonShow = false
            case .badLoading:
                self.errorTitle = "Bad Loading."
                self.errorSolution = "Something went wrong with data loading. Contact developer "
                self.errorImage = "astronaut"
                self.retryButtonShow = true
            }
        } else {
            self.errorTitle = "Connections issues"
            self.errorSolution = "Check Internet connection and retry."
            self.errorImage = "astronaut"
            self.retryButtonShow = true
        }
    }
    
}



