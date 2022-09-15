//
//  graphic.swift
//  Asgmt0405
//
//  Created by Alexandria Armknecht on 4/11/22.
//

import SwiftUI

struct graphic: View {
    static let gradientStart = Color(red: 85.0 / 255, green: 100 / 255, blue: 100.0 / 255)
    static let gradientEnd = Color(red: 0.0 / 255, green: 10.0 / 255, blue: 50.0 / 255)
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(to: CGPoint(x: 100, y: 2000))
                path.addArc(center: .init(x: 200, y: 200), radius: 100, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 0.01), clockwise: true)
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

struct graphic_Previews: PreviewProvider {
    static var previews: some View {
        graphic()
    }
}
}
