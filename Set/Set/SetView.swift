//
//  SetView.swift
//  Set
//
//  Created by Cayden Wagner on 12/30/24.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var viewModel: SetViewModel
    private let aspectRatio: CGFloat = 6/4
    
    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card: card)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(card.isSelected ? Color.red : Color.black, lineWidth: card.isSelected ? 4 : 2)
                )
                .onTapGesture {
                    viewModel.select(card)
                }
            .padding(5)
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
