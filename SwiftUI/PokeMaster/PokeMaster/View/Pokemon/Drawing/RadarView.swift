//
//  RadarView.swift
//  PokeMaster
//
//  Created by user on 2024/3/6.
//

import SwiftUI

struct RadarView: View {
    let values: [Int]
    let color: Color
    var max: Int
    let progress: CGFloat
    let shouldAnimate: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Hexagon(
                    values: Array(repeating: max, count: 6),
                    max: max,
                    progress: progress
                )
                .stroke(color.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [6,3]))
                .animation(shouldAnimate ? .linear(duration: 1).delay(0.2): nil , value: progress)
                
                
                Hexagon(
                    values: values,
                    max: max,
                    progress: progress
                )
                .fill(linearGradient)
                .animation(shouldAnimate ? .linear(duration: 1.5).delay(0.2): nil , value: progress)
            }
            .frame(
                width: min(geometry.size.width, geometry.size.height),
                height: min(geometry.size.width, geometry.size.height)
            )
        }
    }
    
    var linearGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [color, color.opacity(0.1)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
}

struct Hexagon: Shape {
    let values: [Int]
    let max: Int
    var progress: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let points = self.points(in: rect)
            path.move(to: points.first!)
            for p in points.dropFirst() {
                path.addLine(to: p)
            }
            path.closeSubpath()
        }
        .trimmedPath(from: 0, to: progress)
    }
    
    var animatableData: CGFloat {
        set { progress = newValue }
        get { progress }
    }
    
    func points(in rect: CGRect) -> [CGPoint] {
        zip(
            self.values,
            [0, 60, 120, 180, 240, 300].map { Angle.degrees($0) }
        ).map {
            convert(value: $0.0, angle: $0.1, in: rect)
        }
    }
    
    func convert(value: Int, angle: Angle, in rect: CGRect) -> CGPoint {
        let x = 0.5 * rect.width * (1 + CGFloat(value) / CGFloat(max) * CGFloat(sin(angle.radians)))
        let y = 0.5 * rect.height * (1 - CGFloat(value) / CGFloat(max) * CGFloat(cos(angle.radians)))
        return .init(x: x, y: y)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var progress: CGFloat = 0.0
        
        var body: some View {
            VStack {
                RadarView(
                    values: [165,129,148,176,152,140],
                    color: .red,
                    max: 200,
                    progress: progress,
                    shouldAnimate: true
                )
                .frame(width: 300, height: 300)
            }
            Button(action: {
                self.progress = 1.0
            }, label: {
                Text("動畫")
            })
        }
    }
    return PreviewWrapper()
}
