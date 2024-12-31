//
//  SetView.swift
//  Set
//
//  Created by Cayden Wagner on 12/30/24.
//

import SwiftUI

struct SetView: View {
    @ObservedObject var viewModel: SetViewModel
    private let aspectRatio: CGFloat = 2/3
    
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
                .padding(2)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(card.isSelected ? Color.red : Color.black, lineWidth: card.isSelected ? 4 : 2)
                        .padding(4)
                )
                .onTapGesture {
                    viewModel.select(card)
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
                
                ShapeBuilder(shape: card.content)
            }
        }
    }
}

#Preview {
    SetView(viewModel: SetViewModel())
}
