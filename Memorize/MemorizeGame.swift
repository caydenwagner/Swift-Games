//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Cayden Wagner on 12/25/24.
//

import Foundation

struct MemorizeGame<CardContent> {
    var Cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
