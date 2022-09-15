//
//  BadgeBackground.swift
//  planets
//
//  Created by Alexandria Armknecht on 2/10/22.
//

import SwiftUI

struct BadgeBackground: View {
    static let gradientStart = Color(red: 85.0 / 255, green: 0 / 255, blue: 170.0 / 255)
    static let gradientEnd = Color(red: 0.0 / 255, green: 10.0 / 255, blue: 50.0 / 255)
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint(x: 200, y: 200))
                path.addArc(center: .init(x: 200, y: 200), radius: 150, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 0.01), clockwise: true)
        }
        .fill(.linearGradient(
            Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
            startPoint: UnitPoint(x: 0.5, y: 0),
            endPoint: UnitPoint(x: 0.5, y: 0.6)
                                    ))
        .aspectRatio(1, contentMode: .fit)
    }
        .background(Color.black)
        
}

struct BadgeBackground_Previews: PreviewProvider {
    static var previews: some View {
        BadgeBackground()
    }
}
}
