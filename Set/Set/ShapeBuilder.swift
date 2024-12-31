//
//  ShapeBuilder.swift
//  Set
//
//  Created by Cayden Wagner on 12/30/24.
//

import SwiftUI

struct ShapeBuilder: View {
    let shape: SetModel.Shape
    
    var body: some View {
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
        .aspectRatio(2, contentMode: .fit)
        .rotationEffect(.degrees(90))
    }
}

struct PillShape: View {
    let color: Color
    let fillType: SetModel.FillType
    
    var body: some View {
        Capsule()
            .stroke(color, lineWidth: 4)
            .fill(fillColor(for: fillType, color: color))
            .overlay(
                Capsule()
                    .fill(.white)
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
            return 0
        case .transparent:
            return 0.5
        case .open:
            return 1
        }
    }
}

struct SquigglyShape: View {
    let color: Color
    let fillType: SetModel.FillType
    
    var body: some View {
        SquigglyShapeView()
            .stroke(color, lineWidth: 4)
            .fill(fillColor(for: fillType, color: color))
            .overlay(
                SquigglyShapeView()
                    .fill(.white)
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
            return 0
        case .transparent:
            return 0.5
        case .open:
            return 1
        }
    }
}

struct DiamondShape: View {
    let color: Color
    let fillType: SetModel.FillType
    
    var body: some View {
        DiamondShapeView()
            .stroke(color, lineWidth: 4)
            .fill(fillColor(for: fillType, color: color))
            .overlay(
                DiamondShapeView()
                    .fill(.white)
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
            return 0
        case .transparent:
            return 0.5
        case .open:
            return 1
        }
    }
}

struct SquigglyShapeView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        
        // Start at the top-left
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        
        // Top-left curve
        path.addCurve(to: CGPoint(x: rect.minX + width * 0.2, y: rect.minY),
                      control1: CGPoint(x: rect.minX, y: rect.minY + height * 0.2),
                      control2: CGPoint(x: rect.minX + width * 0.1, y: rect.minY))
        
        // Top-right curve
        path.addCurve(to: CGPoint(x: rect.minX + width * 0.8, y: rect.minY),
                      control1: CGPoint(x: rect.minX + width * 0.5, y: rect.minY),
                      control2: CGPoint(x: rect.minX + width * 0.6, y: rect.minY + height * 0.35))
        
        // Bottom-right curve
        path.addCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                      control1: CGPoint(x: rect.minX + width * 0.9, y: rect.minY),
                      control2: CGPoint(x: rect.maxX, y: rect.minY + height * 0.2))
        
        // Bottom-left curve
        path.addCurve(to: CGPoint(x: rect.minX + width * 0.8, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX, y: rect.maxY - height * 0.2),
                      control2: CGPoint(x: rect.minX + width * 0.9, y: rect.maxY))
        
        // Bottom-left curve
        path.addCurve(to: CGPoint(x: rect.minX + width * 0.2, y: rect.maxY),
                      control1: CGPoint(x: rect.minX + width * 0.6, y: rect.maxY),
                      control2: CGPoint(x: rect.minX + width * 0.4, y: rect.maxY - height * 0.35))
        
        // Close the path
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
    ShapeBuilder(shape: SetModel.Shape(shapeType: .squiggly, color: .red, fillType: .transparent))
}
