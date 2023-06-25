//
//  AnimationsComponents.swift
//  quoteOfTheDay
//
//  Created by Artem on 23/06/2023.
//

import SwiftUI

struct LoaderView: View {
    @State private var circleSize: CGFloat = 500
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


struct ContentLoaderView: View {
    @State var progress:CGFloat = 0
    var body: some View {
        ZStack {
          Circle()
            .stroke(
                Color.gray.opacity(0.5),
                lineWidth: 5)
        
            Circle()
                .trim(from: 0, to: progress)
           .stroke(
               Color.blue,
               style: StrokeStyle(
                   lineWidth: 5,
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

struct SlidingLoaderView: View {
    @State private var isLoaded: Bool = false
    
    var body: some View {
        ZStack {
            AngularGradient(colors: [.cyan, .blue, .green], center: .center, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: isLoaded ? 360 : 0)).ignoresSafeArea()
         
        }
            .onAppear {
                withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)){
                    self.isLoaded.toggle()
                }
            }
    }
}



struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
        ContentLoaderView()
        SlidingLoaderView()
        ShareButton()
    }
}


struct ShareButton: View {
    @State var isMoving: Bool = false
    var body: some View {
        ZStack {
            BlobShape()
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: isMoving ? 0 : 90))
            
            BlobShape()
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: isMoving ? 160 : 45))
            BlobShape()
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: isMoving ? 120 : 270))
            BlobShape()
                .foregroundColor(.blue)
                .rotationEffect(Angle(degrees: isMoving ? 0 : 180))

        }.onAppear{
            withAnimation(.easeInOut(duration: 6.0).repeatForever(autoreverses: true)) {
                isMoving.toggle()
            }
        }
    }
}


struct BlobShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.77415*width, y: 0.18185*height))
        path.addCurve(to: CGPoint(x: 0.00007*width, y: 0.48499*height), control1: CGPoint(x: 0.45688*width, y: -0.058*height), control2: CGPoint(x: -0.00374*width, y: -0.15127*height))
        path.addCurve(to: CGPoint(x: 0.76078*width, y: 0.84476*height), control1: CGPoint(x: 0.00388*width, y: 1.12125*height), control2: CGPoint(x: 0.45879*width, y: 1.07295*height))
        path.addCurve(to: CGPoint(x: 0.77415*width, y: 0.18185*height), control1: CGPoint(x: 1.06276*width, y: 0.61657*height), control2: CGPoint(x: 1.09143*width, y: 0.4217*height))
        path.closeSubpath()
        return path
    }
}
