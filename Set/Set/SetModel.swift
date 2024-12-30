//
//  SetModel.swift
//  Set
//
//  Created by Cayden Wagner on 12/29/24.
//

import Foundation
import SwiftUI

struct SetModel {
    private(set) var displayCards: [Card]
    private var deck: [Card]
    
    init(theme: Theme = .original, numCards: Int = 24) {
        deck = []
        displayCards = []
        
        for shape in ShapeType.allCases {
            for fill in FillType.allCases {
                for color in theme.colors {
                    for numberOfShapes in 1...3 {
                        let shapeContent = Shape(shapeType: shape, color: color, fillType: fill)
                        let card = Card(content: shapeContent, numberOfShapes: numberOfShapes)
                        deck.append(card)
                    }
                }
            }
        }
        
        deck.shuffle()
        
        for _ in 0..<min(numCards, deck.count) {
            if let card = deck.popLast() {
                displayCards.append(card)
            }
        }
    }
    
    struct Card: Equatable, Identifiable {
        static func == (lhs: SetModel.Card, rhs: SetModel.Card) -> Bool {
            return lhs.id == rhs.id
        }
        
        var isFaceUp = false
        var isMatched = false
        let content: Shape
        var numberOfShapes: Int
        
        var id: UUID = UUID()
    }
    
    struct Shape {
        var shapeType: ShapeType
        var color: Color
        var fillType: FillType
    }
    
    enum ShapeType: CaseIterable {
        case pill
        case squiggly
        case diamond
    }
    
    enum FillType: CaseIterable {
        case solid
        case striped
        case open
    }
    
    enum Theme {
        case halloween
        case christmas
        case original
        case neon
        
        var colors: [Color] {
            switch self {
            case .halloween:
                return [.orange, .black, .purple, .green, .red]
            case .christmas:
                return [.red, .green, .white, .black, .purple]
            case .original:
                return [.red, .blue, .green, .yellow, .purple]
            case .neon:
                return [.cyan, .purple, .yellow, .teal, .pink]
            }
        }
    }
}
