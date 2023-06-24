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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
       
        Circle()
            .frame(width: 50, height: 50)
            .foregroundColor(.blue)
        
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView(progress: 0.0)
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
