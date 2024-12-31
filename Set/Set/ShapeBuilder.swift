//
//  ShapeBuilder.swift
//  Set
//
//  Created by Cayden Wagner on 12/30/24.
//

//
//  ShapeBuilder.swift
//  Set
//
//  Created by Cayden Wagner on 12/30/24.
//

import SwiftUI

struct ShapeBuilder: View {
    let shape: SetModel.Shape
    let numberOfShapes: Int
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 4) {
                ForEach(0..<numberOfShapes, id: \.self) { _ in
                    shapeView
                        .frame(width: geometry.size.width * 0.45, height: geometry.size.height * 0.4)
                        .padding(2)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .rotationEffect(.degrees(90))
    }
    
    private var shapeView: some View {
        Group {
            switch shape.shapeType {
            case .pill:
                PillShape(color: shape.color, fillType: shape.fillType)
            case .squiggly:
                SquigglyShape(color: shape.color, fillType: shape.fillType)
            case .diamond:
                DiamondShape(color: shape.color, fillType: shape.fillType)
            }
        }
    }
}

struct PillShape: View {
    let color: Color
    let fillType: SetModel.FillType
    
    var body: some View {
        Capsule()
            .stroke(color, lineWidth: 2)
            .background(
                Capsule()
                    .fill(fillColor(for: fillType, color: color))
                    .opacity(opacity(for: fillType))
            )
    }
    
    private func fillColor(for fillType: SetModel.FillType, color: Color) -> Color {
        switch fillType {
        case .solid:
            return color
        case .transparent:
            return color.opacity(0.5)
        case .open:
            return Color.clear
        }
    }
    
    private func opacity(for fillType: SetModel.FillType) -> Double {
        switch fillType {
        case .solid:
            return 1
        case .transparent:
            return 0.5
        case .open:
            return 0
        }
    }
}

struct SquigglyShape: View {
    let color: Color
    let fillType: SetModel.FillType
    
    var body: some View {
        SquigglyShapeView()
            .stroke(color, lineWidth: 2)
            .background(
                SquigglyShapeView()
                    .fill(fillColor(for: fillType, color: color))
                    .opacity(opacity(for: fillType))
            )
    }
    
    private func fillColor(for fillType: SetModel.FillType, color: Color) -> Color {
        switch fillType {
        case .solid:
            return color
        case .transparent:
            return color.opacity(0.5)
        case .open:
            return Color.clear
        }
    }
    
    private func opacity(for fillType: SetModel.FillType) -> Double {
        switch fillType {
        case .solid:
            return 1
        case .transparent:
            return 0.5
        case .open:
            return 0
        }
    }
}

struct DiamondShape: View {
    let color: Color
    let fillType: SetModel.FillType
    
    var body: some View {
        DiamondShapeView()
            .stroke(color, lineWidth: 2)
            .background(
                DiamondShapeView()
                    .fill(fillColor(for: fillType, color: color))
                    .opacity(opacity(for: fillType))
            )
    }
    
    private func fillColor(for fillType: SetModel.FillType, color: Color) -> Color {
        switch fillType {
        case .solid:
            return color
        case .transparent:
            return color.opacity(0.5)
        case .open:
            return Color.clear
        }
    }
    
    private func opacity(for fillType: SetModel.FillType) -> Double {
        switch fillType {
        case .solid:
            return 1
        case .transparent:
            return 0.5
        case .open:
            return 0
        }
    }
}

struct SquigglyShapeView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        
        path.addCurve(to: CGPoint(x: rect.minX + width * 0.2, y: rect.minY),
                      control1: CGPoint(x: rect.minX, y: rect.minY + height * 0.2),
                      control2: CGPoint(x: rect.minX + width * 0.1, y: rect.minY))
        
        path.addCurve(to: CGPoint(x: rect.minX + width * 0.8, y: rect.minY),
                      control1: CGPoint(x: rect.minX + width * 0.5, y: rect.minY),
                      control2: CGPoint(x: rect.minX + width * 0.6, y: rect.minY + height * 0.35))
        
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                      control1: CGPoint(x: rect.minX + width * 0.9, y: rect.minY),
                      control2: CGPoint(x: rect.maxX, y: rect.minY + height * 0.2))
        
        path.addCurve(to: CGPoint(x: rect.minX + width * 0.8, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX, y: rect.maxY - height * 0.2),
                      control2: CGPoint(x: rect.minX + width * 0.9, y: rect.maxY))
        
        path.addCurve(to: CGPoint(x: rect.minX + width * 0.2, y: rect.maxY),
                      control1: CGPoint(x: rect.minX + width * 0.6, y: rect.maxY),
                      control2: CGPoint(x: rect.minX + width * 0.4, y: rect.maxY - height * 0.35))
        
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.midY),
                      control1: CGPoint(x: rect.minX + width * 0.1, y: rect.maxY),
                      control2: CGPoint(x: rect.minX, y: rect.maxY - height * 0.2))
        
        return path
    }
}

struct DiamondShapeView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    ShapeBuilder(shape: SetModel.Shape(shapeType: .squiggly, color: .red, fillType: .transparent), numberOfShapes: 3)
}
