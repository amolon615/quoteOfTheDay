//
//  QuoteViewModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI


class QuotesViewModel: ObservableObject {
    private var manager = DataManager()
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
    private func pickPage() -> String {
        let skipValue = quotesList.count
        DispatchQueue.main.async {
                self.currentPage += 1
        }
        return "?skip=\(skipValue)"
    }
    
    
    //fetch data function, works for both fetching 1 quote by id (nil by default) and all quotes
    private func fetchData(withID id: String? = nil) async {
        do {
            if let quoteID = id {
                let fetchedQuote: Quote = try await manager.fetchData(url: "https://dummyjson.com/quotes/", paramId: quoteID)
                DispatchQueue.main.async {
                    self.quote = fetchedQuote
                    print("one quote downloaded")
                }
            } else {
                let fetchedQuotes: Quotes = try await manager.fetchData(url: "https://dummyjson.com/quotes/", page: pickPage())
                DispatchQueue.main.async {
                    self.quotesList.append(contentsOf: fetchedQuotes.quotes)
                    print("quotes downloaded")
                }
            }
        } catch let error {
            DispatchQueue.main.async {
                self.handleFetchDataError(error)
            }
        }
    }
    
    
    //In case of this app not each have actionable solution. For the final app all cases where user can't fix anything (badDecoding, badURL, badLoading) button should allow to contact developer.
    //These cases could occure if 3rd party servers like dummyJSON or pexels change their JSON schema.
    //For the errors like connection issues it's might be handy to allow user to reload the data, what I did.
    
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
    

    
    
    //fetching data and loading
    func loadData(withID id: String? = nil) {
        Task {
            await fetchData(withID: id)
        }
    }
}


