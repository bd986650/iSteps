//
//  ActivityRing.swift
//  iSteps
//
//  Created by Данил Белов on 06.07.2023.
//

import SwiftUI

struct ActivityArrow: View {
    private let startPoint = CGPoint(x: 20, y: 20)

    var body: some View {
        return Path { p in
            p.move(to: startPoint)
            p.addLine(to: CGPoint(x: 0, y: 20))

            p.move(to: startPoint)
            p.addLine(to: CGPoint(x: 12, y: 8))

            p.move(to: startPoint)
            p.addLine(to: CGPoint(x: 12, y: 32))
        }
        .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round))
    }
}

struct ActivityRing: View {
    var progress: CGFloat

    // offset for closing circle and arrows
    private var fullCircleDotOffset: CGFloat { return 300 * -0.82 / 2 }
    private let ringThickness: CGFloat = 60.0

    private var ringColor: [Color] {
        get {
            [Color.darkRed,
             Color.mainRed]
        }
    }

    var body: some View {
        ZStack {
            if self.progress < 0.98 {
                // background ring
                Circle()
                    .scale(0.82)
                    .stroke(self.ringColor[1], lineWidth: self.ringThickness)

                // Activity Ring
                Circle()
                    .scale(0.82)
                    .trim(from: 0, to: self.progress)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [self.ringColor[0], self.ringColor[1]]),
                            center: .center,
                            startAngle: .degrees(0.0),
                            endAngle: .init(degrees: 360.0)
                        ),
                        style: StrokeStyle(lineWidth: self.ringThickness, lineCap: .round))
                    .rotationEffect(.degrees(-90.0))

                // fix overlapping gradient from full cycle
                Circle()
                    .frame(width: self.ringThickness, height: self.ringThickness)
                    .foregroundColor(self.ringColor[0])
                    .offset(y: self.fullCircleDotOffset)

            } else {
                // Activity Ring
                Circle()
                    .scale(0.82)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [self.ringColor[0], self.ringColor[1]]),
                            center: .center,
                            startAngle: .degrees(0.0),
                            endAngle: .init(degrees: 360.0)
                        ),
                        style: StrokeStyle(lineWidth: self.ringThickness, lineCap: .round))
                    .rotationEffect(.degrees((360 * Double(self.progress)) - 90))

                // TODO let Circle overlap of underlying ring
                Circle()
                    .frame(width: self.ringThickness, height: self.ringThickness)
                    .offset(y: self.fullCircleDotOffset)
                    .foregroundColor(self.ringColor[1]) // TODO insert linear Gradient
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: self.ringThickness / 4, y: 0)
                    .rotationEffect(.degrees(360 * Double(self.progress)))
            }

            // Activity Arrows
            ActivityArrow()
                .foregroundColor(.black)
                .frame(width: 40, height: 40)
                .rotationEffect(.degrees(0))
                .offset(x: 5, y: self.fullCircleDotOffset)
        }
        .frame(width: 300, height: 300)
    }
}

struct ActivityRing_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRing(progress: 5000.58)
    }
}
