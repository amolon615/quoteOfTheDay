//
//  DetailedView.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

struct DetailedQuoteView: View {
    @ObservedObject var vm = QuotesViewModel()
     var authorId: String
       var body: some View {
           if let quote = vm.quote {
               ZStack {
                   LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                   VStack (alignment: .center, spacing: 50){
                       Text(quote.quote).multilineTextAlignment(.center)
                       Text(quote.author)
                   }
                   .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.2)
                   .background(
                    .thickMaterial
                   )
                   .cornerRadius(20)
               }
               
            } else {
               LoaderView()
                   .frame(width: 250, height: 250)
                   .onAppear {
                       Task {
                           await vm.fetchQuoteData(withID: authorId)
                    }
                }
        }
    }
    
}


struct DetailedQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedQuoteView(authorId: "1")
    }
}
