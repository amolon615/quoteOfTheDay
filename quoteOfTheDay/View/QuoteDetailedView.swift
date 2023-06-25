//
//  DetailedView.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

struct DetailedQuoteView: View {
    @EnvironmentObject var vm: QuotesViewModel
    @StateObject var qmVM = QuoteManager()
    
    var authorId: String
    @State var isLoading = true
       var body: some View {
           if let quote = vm.quote, isLoading == false {
               ZStack {
                   GradientBackgroundView()
                   VStack (alignment: .center, spacing: 50){
                       Text( "\"\(quote.quote)\"")
                           .multilineTextAlignment(.center)
                           .font(.system(size: 30, weight: .semibold, design: .rounded))
                       Text(quote.author)
                       ShareLink(item: qmVM.quoteToShare, preview: SharePreview(quote.author, image: qmVM.quoteToShare)) {
                           ZStack {
                               ShareButton()
                               Image(systemName: "square.and.arrow.up.circle")
                                   .font(.system(size: 30, weight: .semibold, design: .rounded))
                                   .foregroundColor(.white.opacity(0.75))
                           }
                               .frame(width: 60, height: 60)
                       }
                           

                   }
                   .padding()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: .infinity)
                   .fixedSize(horizontal: false, vertical: true)
                   .background(
                    .ultraThinMaterial
                   )
                   .cornerRadius(20)
                   .onDisappear {
                       vm.quote = nil
                   }
                   
               }
               .onAppear {
                   let viewToImage = quoteCard.environmentObject(vm)
                       qmVM.Save(view: viewToImage)
                   
               }
           } else {
               SlidingLoaderView().ignoresSafeArea()
                   .onAppear {
                        vm.loadData(withID: authorId) 
                       DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                           withAnimation(.easeOut(duration: 1.0)){
                               self.isLoading = false
                           }
                       }
                   }
           }
    }
    
        //sharing quote card (removed sharing button)
    var quoteCard: some View {
            ZStack {
                GradientBackgroundView()
                VStack (alignment: .center, spacing: 50){
                    if let quote = vm.quote {
                        Text( "\"\(quote.quote)\"")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text(quote.author)
                    }
                }
                .padding()
                 .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: .infinity)
                .fixedSize(horizontal: false, vertical: true)
                .background(
                 .ultraThinMaterial
                )
                .cornerRadius(20)
            }
        }
}


struct DetailedQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedQuoteView(authorId: "1")
            .environmentObject(QuotesViewModel())
            .environmentObject(ImagesViewModel())
    }
}
