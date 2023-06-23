//
//  ContentView.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI


struct QuotesList: View {
    @EnvironmentObject var vm: QuotesViewModel
    @EnvironmentObject var router: Router
    

    var body: some View {
                if let quotes = vm.quotes {
                    ZStack {
                        List(quotes.quotes) { quote in
                            Button(quote.quote) {
                                router.navigate(to: .detailedQuoteView(authorId: String(quote.id)))
                            }
                        }
                    }
                } else {
                    LoaderView()
                        .frame(width: 250, height: 250)
                        .onAppear {
                            if vm.quotes == nil {
                                vm.loadData()
                                }
                        }
                }
           
    }
}



struct QuotesList_Previews: PreviewProvider {
    static var previews: some View {
        QuotesList()
            .environmentObject(QuotesViewModel())
            .environmentObject(Router())
    }
}
