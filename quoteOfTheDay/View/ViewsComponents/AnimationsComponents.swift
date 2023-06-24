//
//  AnimationsComponents.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

struct LoaderView: View {
    @State private var circleSize: CGFloat = 10.0
       @State private var isAnimating = false
    
    var body: some View {
        Circle()
                .foregroundColor(.blue)
                .frame(width: circleSize, height: circleSize)
                .scaleEffect(isAnimating ? 4.0 : 1.0)
                .opacity(isAnimating ? 0.0 : 1.0)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)){
                        self.isAnimating = true
                    }
                }
        
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}


//
//ZStack {
//  Circle()
//    .stroke(
//        Color.blue.opacity(0.5),
//        lineWidth: 5)
//
//    Circle()
//        .trim(from: 0, to: progress)
//   .stroke(
//       Color.blue,
//       style: StrokeStyle(
//           lineWidth: 5,
//           lineCap: .round
//       )
//               )
//               .rotationEffect(.degrees(-90))
//       }

//    .onAppear {
//        withAnimation(.easeInOut(duration: 0.3)){
//            progress = 1
//        }
//    }
