//
//  QuoteViewModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI


class QuotesViewModel: ObservableObject {
    var manager = DataManager()
    var router = Router()
    
    @Published var quotes: Quotes? = nil
    @Published var quote: Quote? = nil
    @Published var error: QuoteLoadingError? = nil
    @Published var pageNumb: Int = 0
    @Published var limitNub: Int = 10
    
    
    //navigation direction selector
    func getDirection(direction: String) {
        print("page number is \(pageNumb)")
        if direction == "forward" {
              if pageNumb < 2 {
                  pageNumb += 1
              } else {
                  pageNumb = 0
              }
          } else {
              if pageNumb > 0 {
                  pageNumb -= 1
              } else {
                  pageNumb = 2
              }
          }
    }
    
    //scroll pages
    private func pickPage() -> String {
        switch pageNumb {
        case 0:
            return "0"
        case 1:
            return "50"
        default:
            return "0"
        }
    }
    
    //set limit for quotes per pages
    private func setLimitPerPage() -> String {
        switch limitNub {
        case 10:
            return "&limit=10"
        case 20:
            return "&limit=20"
        case 30:
            return "&limit=30"
        case 40:
            return "&limit=40"
        case 50:
            return "&limit=50"
        default:
            return "&limit=10"
        }
    }
    
    //fetching all quotes
    func fetchData() async throws {
     
        do {
            let fetchedQuotes: Quotes = try await manager.fetchData(url: "https://dummyjson.com/quotes/?skip=", page: pickPage(), limit: setLimitPerPage())
            DispatchQueue.main.async {
                self.quotes = fetchedQuotes
            }
        } catch let error as QuoteLoadingError {
            DispatchQueue.main.async {
                    self.error = error
            }
        } catch {
            DispatchQueue.main.async {
                self.error = QuoteLoadingError.badDecoding
            }
        }
    }
    
    //fetching 1 quote by provided id
    func fetchQuoteData(withID id: String) async {
         do {
             let fetchedQuote: Quote = try await manager.fetchData(url: "https://dummyjson.com/quotes/", paramId: id)
             DispatchQueue.main.async {
                 self.quote = fetchedQuote
                 print("fetched quote is : \(String(describing: self.quote))")
             }
         } catch let error as QuoteLoadingError {
             DispatchQueue.main.async {
                     self.error = error
             }
         } catch {
             DispatchQueue.main.async {
                 self.error = QuoteLoadingError.badDecoding
             }
         }
     }
    
    //loading data
    func loadData() {
            Task {
                do {
                    try await fetchData()
                } catch {
                    DispatchQueue.main.async {
                        self.error = QuoteLoadingError.badDecoding
                    }
                }
            }
        }
    
    
    
}


