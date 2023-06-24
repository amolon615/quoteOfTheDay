//
//  GradientBackgroundView.swift
//  quoteOfTheDay
//
//  Created by Artem on 24/06/2023.
//

import SwiftUI

struct GradientBackgroundView: View {
    @State private var rotate: Bool = false
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan.opacity(0.7), .green, .blue]), startPoint: rotate ? .topLeading : .bottomTrailing, endPoint: .trailing)
                       .ignoresSafeArea()
                       .overlay(
                        .ultraThinMaterial
                       )
                       .onAppear {
                           withAnimation(.linear(duration: 4.0).repeatForever(autoreverses: true)){
                               self.rotate.toggle()
                           }
                       }
            
        }
    }
}

struct GradientBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackgroundView()
    }
}
