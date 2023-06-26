//
//  DetailQuoteViewModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 25/06/2023.
//

import SwiftUI

//controlling the detailed quote, allowing to construct a card for sharing button and making a snapshot
class QuoteViewModel: ObservableObject {
     let cgWidth: CGFloat = UIScreen.main.bounds.width
     let cgHeight: CGFloat = UIScreen.main.bounds.height
        
    @Published var quoteToShare: Image = Image("astronaut")

    //saving view to UIImage, creating Image to share.
    func Save(view: any View){
        let highresImage = view.asImage(size: CGSize(width: cgWidth, height: cgHeight))
        self.quoteToShare = Image(uiImage: highresImage)
    }
}
