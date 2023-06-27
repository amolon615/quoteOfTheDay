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


    var body: some View {
        if imagesVM.imagesDidLoad && vm.quotesDidLoad == true {
            ScrollView (showsIndicators: false) {
                    
                        ForEach(Array(vm.quotes!.quotes.enumerated()), id:\.element) { index, quote in
                            CellView(imageNum: imagesVM.imageURLs[index], quoteText: quote.quote)
                                    .onTapGesture { router.navigate(to: .detailedQuoteView(authorId: String(quote.id)))}
                    }
            }
            //prev & next page buttons
            .overlay ( quotesButtonOverlay )
                } else {
                    LoaderView()
                        .onAppear {
                            vm.loadData()
                            imagesVM.loadImages()
                            }
                }
    }
    
    //page buttons overlay
    private var quotesButtonOverlay: some View {
        VStack {
            Spacer()
            HStack {
                ZStack {
                    Circle()
                    Image(systemName: "arrow.left.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                }
                    .frame(width: 60)
                    .foregroundColor(.black.opacity(0.7))
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        vm.getDirection(direction: "previous")
                        vm.loadData()
                        imagesVM.loadImages()
                    }
                Spacer()
                ZStack {
                    Circle()
                    Image(systemName: "arrow.right.circle")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                }
                    .frame(width: 60)
                    .foregroundColor(.black.opacity(0.7))
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                    .onTapGesture {
                        vm.getDirection(direction: "forward")
                        vm.loadData()
                        imagesVM.loadImages()
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




