//
//  ContentView.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI


struct QuotesList: View {
    @EnvironmentObject var vm: QuotesViewModel
    @EnvironmentObject var imagesVM: ImagesViewModel
    @EnvironmentObject var router: Router

    @State var refreshLoader: Bool = true
    var body: some View {
        
     
        if imagesVM.imagesDidLoad && vm.quotes != nil && refreshLoader == false {
            ScrollView (showsIndicators: false) {
                ForEach(Array(vm.quotes!.quotes.enumerated()), id:\.element) { index, quote in
                    CellView(imageNum: imagesVM.imageURLs[index], quoteText: quote.quote)
                            .onTapGesture { router.navigate(to: .detailedQuoteView(authorId: String(quote.id)))}
                    }
            }
                } else {
                    LoaderView()
//                            .frame(width: 250, height: 250)
                            .onAppear {
                                    vm.loadData()
                                    imagesVM.loadImages()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    withAnimation(.easeIn(duration: 1.5)) {
                                        refreshLoader = false
                                    }
                                }
                            }
                            
                }
    }
}


struct QuotesList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


