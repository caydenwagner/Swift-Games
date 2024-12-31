//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Cayden Wagner on 12/25/24.
//

import SwiftUI

class SetViewModel: ObservableObject {
    private static func createSetGame() -> SetModel {
        return SetModel()
    }
        
    @Published private(set) var model: SetModel
    
    init(model: SetModel = SetModel()) {
        self.model = model
    }
    
    var cards: [SetModel.Card] {
        return model.displayCards
    }
    
    // MARK: - Intents
    
    func select(_ card: SetModel.Card) {
        model.select(card)
    }
    
    func checkForMatches() {
        model.highlightAvailableMatches()
    }
    
    func startNewGame() {
        model = SetViewModel.createSetGame()
    }
    
    var hasAvailableMatches: Bool {
        return model.hasAvailableMatches()
    }
}
