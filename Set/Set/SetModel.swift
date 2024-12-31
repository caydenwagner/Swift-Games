import Foundation
import SwiftUI

struct SetModel {
    private(set) var displayCards: [Card]
    private var deck: [Card]
    private(set) var numberOfDisplayCards: Int
    
    init(theme: Theme = .original, numberOfDisplayCards: Int = 12) {
        deck = []
        displayCards = []
        self.numberOfDisplayCards = numberOfDisplayCards
        
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
        let selectedCards = displayCards.filter { $0.isSelected }
        
        if isValidSet(selectedCards) {
            for card in selectedCards {
                if let index = displayCards.firstIndex(where: { $0.id == card.id }) {
                    displayCards[index].isMatched = true
                }
            }
            
            displayCards.removeAll(where: { $0.isMatched })
            
            addNewCards()
        } else {
            for card in selectedCards {
                if let index = displayCards.firstIndex(where: { $0.id == card.id }) {
                    displayCards[index].isSelected = false
                }
            }
        }
    }
    
    private mutating func addNewCards() {
        clearMatches()
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
        let numberOfShapes = Set(cards.map { $0.numberOfShapes })
        
        return (shapeTypes.count == 1 || shapeTypes.count == 3) &&
               (fillTypes.count == 1 || fillTypes.count == 3) &&
               (colors.count == 1 || colors.count == 3) &&
               (numberOfShapes.count == 1 || numberOfShapes.count == 3)
    }
    
    mutating func highlightAvailableMatches() {
        clearMatches()
        for i in 0..<displayCards.count {
            for j in (i + 1)..<displayCards.count {
                for k in (j + 1)..<displayCards.count {
                    let potentialSet = [displayCards[i], displayCards[j], displayCards[k]]
                    if isValidSet(potentialSet) {
                        displayCards[i].isPartOfMatch = true
                        displayCards[j].isPartOfMatch = true
                        displayCards[k].isPartOfMatch = true
                        return
                    }
                }
            }
        }
    }
    
    private mutating func clearMatches() {
        for i in 0..<displayCards.count {
            displayCards[i].isPartOfMatch = false
        }
    }
    
    func hasAvailableMatches() -> Bool {
        for i in 0..<displayCards.count {
            for j in (i + 1)..<displayCards.count {
                for k in (j + 1)..<displayCards.count {
                    let potentialSet = [displayCards[i], displayCards[j], displayCards[k]]
                    if isValidSet(potentialSet) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    struct Card: Equatable, Identifiable {
        static func == (lhs: SetModel.Card, rhs: SetModel.Card) -> Bool {
            return lhs.id == rhs.id
        }
        
        var isSelected = false
        var isMatched = false
        var isPartOfMatch = false
        let content: Shape
        let numberOfShapes: Int
        
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
                return [.orange, .black, .green]
            case .christmas:
                return [.red, .green, .black]
            case .original:
                return [.red, .green, .purple]
            case .neon:
                return [.cyan, .yellow, .pink]
            }
        }
    }
}
