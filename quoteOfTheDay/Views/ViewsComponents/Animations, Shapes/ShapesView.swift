//
//  ShapesView.swift
//  quoteOfTheDay
//
//  Created by Artem on 26/06/2023.
//

import SwiftUI

//blob for sharing button
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

struct BlobShape_Previews: PreviewProvider {
    static var previews: some View {
        BlobShape()
    }
}
