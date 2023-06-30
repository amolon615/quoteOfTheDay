//
//  DataHandler.swift
//  quoteOfTheDay
//
//  Created by Artem on 30/06/2023.
//

import SwiftUI



class DataHandler {
    private var manager = DataManager()
    
    var viewModel: QuotesViewModel
    
    init(viewModel: QuotesViewModel, quoteId: String? = nil) {
        self.viewModel = viewModel
    }
    
    
    func loadData(withID id: String? = nil) {
        Task {
            await fetchData(withID: id)
        }
    }
    
    private func handleFetchDataError(_ error: Error) {
        if let quoteLoadingError = error as? QuoteLoadingError {
            switch quoteLoadingError {
            case .badUrl:
                self.viewModel.errorTitle = "Bad URL"
                self.viewModel.errorSolution = "Check URL and re-try."
                self.viewModel.errorImage = "unicorn_black"
                self.viewModel.retryButtonShow = false
            case .badResponse:
                self.viewModel.errorTitle = "Bad Server Response."
                self.viewModel.errorSolution = "Server issues. It has nothing to do with you :)"
                self.viewModel.errorImage = "astronaut"
                self.viewModel.retryButtonShow = true
            case .badDecoding:
                self.viewModel.errorTitle = "Bad Decoding."
                self.viewModel.errorSolution = "Contact developer to check data-models types & structure."
                self.viewModel.errorImage = "unicorn_black"
                self.viewModel.retryButtonShow = false
            case .badLoading:
                self.viewModel.errorTitle = "Bad Loading."
                self.viewModel.errorSolution = "Something went wrong with data loading. Contact developer "
                self.viewModel.errorImage = "astronaut"
                self.viewModel.retryButtonShow = true
            }
        } else {
            self.viewModel.errorTitle = "Connections issues"
            self.viewModel.errorSolution = "Check Internet connection and retry."
            self.viewModel.errorImage = "astronaut"
            self.viewModel.retryButtonShow = true
        }
    }
    
    private func fetchData(withID id: String? = nil) async {
        do {
            if let quoteID = id {
                let fetchedQuote: Quote = try await manager.fetchData(url: "https://dummyjson.com/quotes/", paramId: quoteID)
                DispatchQueue.main.async {
                    self.viewModel.quote = fetchedQuote
                    print("one quote downloaded")
                }
            } else {
                let fetchedQuotes: Quotes = try await manager.fetchData(url: "https://dummyjson.com/quotes/", page: viewModel.pickPage())
                DispatchQueue.main.async {
                    self.viewModel.quotesList.append(contentsOf: fetchedQuotes.quotes)
                    print("quotes downloaded")
                }
            }
        } catch let error {
            DispatchQueue.main.async {
                self.handleFetchDataError(error)
            }
        }
    }
    
    
}

