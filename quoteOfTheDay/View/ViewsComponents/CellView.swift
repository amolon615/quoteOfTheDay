//
//  CellView.swift
//  quoteOfTheDay
//
//  Created by Artem on 24/06/2023.
//

import SwiftUI

struct CellView: View {
    var imageNum: String?
    var quoteText: String
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width * 0.85, height: 200)
                .overlay(
                    Color.black.opacity(0.4)
                )
                .cornerRadius(10)
            
            if let image = imageNum {
                AsyncImage(url: URL(string: image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 0.85, height: 200)
                            .scaledToFill()
                            .overlay(
                                Color.black.opacity(0.4)
                            )
                            .cornerRadius(10)
                    } else if phase.error != nil {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width * 0.85, height: 200)
                            .overlay(
                                Color.blue.opacity(0.7)
                            )
                            .cornerRadius(10)
                    } else {
                        ContentLoaderView()
                            .frame(width: 50, height: 50)
                    }
                }

                .frame(width: UIScreen.main.bounds.width * 0.85, height: 200)
                .scaledToFill()
                .overlay(
                    Color.black.opacity(0.4)
                )
                .cornerRadius(10)

               
            }
            Text("\(quoteText)")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .padding()
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width * 0.7, height: 200)
               
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(imageNum: "https://images.pexels.com/photos/17147165/pexels-photo-17147165.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200", quoteText: "Quote Placeholder")
    }
}
