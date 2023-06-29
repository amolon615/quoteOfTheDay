//
//  CellView.swift
//  quoteOfTheDay
//
//  Created by Artem on 24/06/2023.
//

import SwiftUI


//Images are async, drawing by passing in an url, fetched from the pexels curated list objects.



struct CellView: View {
    var imageNum: String?
    var quoteText: String
    var quoteId: Int
    
    
    //testing lazy-loading
    init(imageNum: String? = nil, quoteText: String, quoteId: Int) {
        self.imageNum = imageNum
        self.quoteText = quoteText
        self.quoteId = quoteId
        print("quote \(self.quoteId) was loaded")
    }
    
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
                    ZStack {
                        Color.black.opacity(0.4)
                        VStack {
                            HStack {
                                ZStack {
                                    Circle()
                                        .frame(width: 25, height: 25)
                                        .opacity(0.5)
                                    Text("\(quoteId)")
                                        .foregroundColor(.white.opacity(0.6))
                                }
                                .padding(.leading, 10)
                                .padding(.top, 10)
                                  
                                Spacer()
                            }
                            Spacer()
                        }
                    }
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
        CellView(imageNum: "https://images.pexels.com/photos/17147165/pexels-photo-17147165.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200", quoteText: "Quote Placeholder", quoteId: 1)
    }
}
