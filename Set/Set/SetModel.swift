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
    private var numberOfDisplayCards: Int
    
    init(theme: Theme = .original, numberOfDisplayCards: Int = 25) {
        deck = []
        displayCards = []
        self.numberOfDisplayCards = numberOfDisplayCards
        
        for shape in ShapeType.allCases {
            for fill in FillType.allCases {
                for color in theme.colors {
                    let shapeContent = Shape(shapeType: shape, color: color, fillType: fill)
                    let card = Card(content: shapeContent)
                    deck.append(card)
                }
            }
        }
        
        deck.shuffle()
        
        displayCards = Array(deck.prefix(numberOfDisplayCards))
        deck.removeFirst(displayCards.count)
    }
    
    mutating func select(_ card: Card) {
        if let chosenIndex = displayCards.firstIndex(where: { $0.id == card.id }) {
            displayCards[chosenIndex].isSelected.toggle()
            
            let selectedCards = displayCards.filter { $0.isSelected }
            if selectedCards.count == 3 {
                checkMatch()
            }
        }
    }
    
    mutating func checkMatch() {
        print("2")
        let selectedCards = displayCards.filter { $0.isSelected }
        
        if isValidSet(selectedCards) {
            print("3")
            for card in selectedCards {
                if let index = displayCards.firstIndex(where: { $0.id == card.id }) {
                    displayCards[index].isMatched = true
                }
            }
            
            displayCards.removeAll(where: { $0.isMatched })
            
            addNewCards()
        } else {
            print("4")
            for card in selectedCards {
                if let index = displayCards.firstIndex(where: { $0.id == card.id }) {
                    displayCards[index].isSelected = false
                }
            }
        }
    }
    
    private mutating func addNewCards() {
        while displayCards.count < numberOfDisplayCards && !deck.isEmpty {
            if let newCard = deck.popLast() {
                displayCards.append(newCard)
            }
        }
    }
    
    private func isValidSet(_ cards: [Card]) -> Bool {
        guard cards.count == 3 else {
            return false
        }
        
        let shapeTypes = Set(cards.map { $0.content.shapeType })
        let fillTypes = Set(cards.map { $0.content.fillType })
        let colors = Set(cards.map { $0.content.color })
        
        return (shapeTypes.count == 1 || shapeTypes.count == 3) &&
               (fillTypes.count == 1 || fillTypes.count == 3) &&
               (colors.count == 1 || colors.count == 3)
    }
    
    struct Card: Equatable, Identifiable {
        static func == (lhs: SetModel.Card, rhs: SetModel.Card) -> Bool {
            return lhs.id == rhs.id
        }
        
        var isSelected = false
        var isMatched = false
        let content: Shape
        
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
        case transparent
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
