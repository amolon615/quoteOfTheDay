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
    
    
    //switch pages, constructing our URL
     func pickPage() -> String {
        let skipValue = quotesList.count
        DispatchQueue.main.async {
                self.currentPage += 1
        }
        return "?skip=\(skipValue)"
    }
    
    func loadQuotes() {
        let dataHandler = DataHandler(viewModel: self)
        dataHandler.loadData()
    }
    
    func loadQuotes(authorId: String?) {
        let dataHandler = DataHandler(viewModel: self)
        dataHandler.loadData(withID: authorId)
    }
   
}


