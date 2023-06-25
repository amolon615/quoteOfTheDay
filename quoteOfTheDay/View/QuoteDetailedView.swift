//
//  DetailedView.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI



struct DetailedQuoteView: View {
    @EnvironmentObject var vm: QuotesViewModel
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
}


struct DetailedQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedQuoteView(authorId: "1")
            .environmentObject(QuotesViewModel())
            .environmentObject(ImagesViewModel())
    }
}
