//
//  SetView.swift
//  Set
//
//  Created by Cayden Wagner on 12/30/24.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var viewModel: SetViewModel
    private let aspectRatio: CGFloat = 7/4
    
    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
            
            buttonBar
                .padding()
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card: card)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(card.isSelected ? Color.red : (card.isPartOfMatch ? Color.yellow : Color.black), lineWidth: card.isSelected ? 4 : 2)
                )
                .onTapGesture {
                    viewModel.select(card)
                }
            .padding(5)
        }
    }
    
    private var buttonBar: some View {
        HStack {
            Circle()
                .fill(viewModel.hasAvailableMatches ? Color.green : Color.gray)
                .frame(width: 20, height: 20)
            
            Button(action: {
                viewModel.checkForMatches()
            }) {
                Text("Highlight Matches")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            // Button to Start New Game
            Button(action: {
                viewModel.startNewGame()
            }) {
                Text("New Game")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
    
    private struct CardView: View {
        let card: SetModel.Card
        
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                
                base
                    .foregroundColor(.white)
                
                ShapeBuilder(shape: card.content, numberOfShapes: card.numberOfShapes)
                    .padding(7)
            }
        }
    }
}

#Preview {
    SetView(viewModel: SetViewModel())
}
