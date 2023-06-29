//
//  ContentView.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

//On selecting Quote author id is passed, so this selected quote could be fetched again on a detailed quote view.

struct QuotesList: View {
    @EnvironmentObject var vm: QuotesViewModel
    @EnvironmentObject var imagesVM: ImagesViewModel
    @EnvironmentObject var router: Router
    
    @State private var dragOffset: CGFloat = 0.0
    @State private var showDragValue = false
    
    
    var body: some View {
        if imagesVM.fetchedPhotos != nil && vm.quotesList.count != 0 {
            ScrollViewReader { scrollProxy in
                ScrollView {
                    LazyVStack {
                        ForEach(Array(vm.quotesList.enumerated()), id:\.element) { index, quote in
                            CellView(imageNum: imagesVM.imageURLs[Int.random(in: 0...59)], quoteText: quote.quote, quoteId: quote.id)
                                .id(quote.id)
                                .onTapGesture { router.navigate(to: .detailedQuoteView(authorId: String(quote.id)))}
                                .simultaneousGesture(
                                    DragGesture()
                                        .onChanged({ value in
                                            if quote.id == vm.quotesList.last?.id {
                                                vm.loadData()
                                            }
                                            
                                        })
                                )
                        }
                    }
                    
                }
            }
        } else {
            LoaderView()
                .onAppear {
                    vm.loadData()
                    imagesVM.loadImages()
                }
        }
    }
}

struct QuotesList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




