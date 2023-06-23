//
//  AnimationsComponents.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

struct LoaderView: View {
    @State var isLoading = false
    @State var progress: Double = 0
    
    var body: some View {
        ZStack {
          Circle()
            .stroke(
                Color.blue.opacity(0.5),
                lineWidth: 30)
                
            Circle()
                .trim(from: 0, to: progress)
           .stroke(
               Color.blue,
               style: StrokeStyle(
                   lineWidth: 30,
                   lineCap: .round
               )
                       )
                       .rotationEffect(.degrees(-90))
               }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3)){
                progress = 1
            }
        }
        
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView(progress: 0.0)
    }
}
