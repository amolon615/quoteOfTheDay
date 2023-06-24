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
       var body: some View {
           if let quote = vm.quote {
               ZStack {
                   LinearGradient(gradient: Gradient(colors: [.black.opacity(0.7), .green, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                       .overlay(
                        .ultraThinMaterial
                       )
                   VStack (alignment: .center, spacing: 50){
                       Text(quote.quote)
                           .multilineTextAlignment(.center)
                           .font(.system(size: 30, weight: .semibold, design: .rounded))
                       Text(quote.author)
                   }.padding()
                  
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
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
               LoaderView()
                   .frame(width: 150, height: 150)
                   .onAppear { Task { await vm.fetchQuoteData(withID: authorId) } }
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
