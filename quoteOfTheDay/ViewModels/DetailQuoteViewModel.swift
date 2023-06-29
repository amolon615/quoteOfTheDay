//
//  DetailQuoteViewModel.swift
//  quoteOfTheDay
//
//  Created by Artem on 25/06/2023.
//

import SwiftUI

//controlling the detailed quote, allowing to construct a card for sharing button and making a snapshot
class QuoteViewModel: ObservableObject {
    @Published var quoteToShare: Image = Image("astronaut")
    
    //saving view to UIImage, creating Image to share.
    func save(view: any View) {
        let highresImage = view.asImage(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.quoteToShare = Image(uiImage: highresImage)
    }
}
