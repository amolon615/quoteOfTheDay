//
//  QuoteViewModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI



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
    
    var dataHandler: DataSourceProtocol
    
    init(dataHandler: DataSourceProtocol = DataHandler()) {
        self.dataHandler = dataHandler
    }
    
    func loadQuotes() {
        Task {
            let fetchdQuotesList = await dataHandler.fetchQuotes(pickPage: self.pickPage())
            guard let fetchdQuotesListUnwrapped = fetchdQuotesList else { return }
            DispatchQueue.main.async {
                self.quotesList = fetchdQuotesListUnwrapped.quotes
            }
        }
    }
    
    func loadQuote(withID id: String) {
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



