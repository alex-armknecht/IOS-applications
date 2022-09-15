//
//  iconView.swift
//  Party Finder
//
//  Created by Alexandria Armknecht on 4/28/22.
//

import SwiftUI
import CoreGraphics

struct iconView: View {
    static let gradientStart = Color(red: 250.0 / 255, green: 0 / 255, blue: 0.0 / 255)
    static let gradientEnd = Color(red: 180.0 / 255, green: 10.0 / 255, blue: 255.0 / 255)
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                //circle
                path.move(to: CGPoint(x: 200, y: 245))
                path.addArc(center: .init(x: 160, y: 130), radius: 30, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 0.01), clockwise: true)
        }
            .fill(Color.blue)
            Path { path in
                //circle
                path.move(to: CGPoint(x: 160, y: 160))
                path.addLine(to: CGPoint(x:260, y: 300))
                path.addLine(to: CGPoint(x:60, y: 300))
                path.addLine(to: CGPoint(x:160, y: 160))
        }
        .fill(.linearGradient(
            Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
            startPoint: UnitPoint(x: 160, y: 90),
            endPoint: UnitPoint(x: 0.5, y: 100)
                                    ))
        .aspectRatio(1, contentMode: .fit)
    }
        .background(Color.black)
    }
}

struct iconView_Previews: PreviewProvider {
    static var previews: some View {
        iconView()
    }
}

