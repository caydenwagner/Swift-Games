//
//  ContentView.swift
//  Memorize
//
//  Created by Cayden Wagner on 12/17/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","🎃","🍭","🕷️","👻","🎃","🍭","🕷️","👻","🎃","🍭","🕷️","👻","🎃","🍭","🕷️"]
    
    var body: some View {
        ScrollView {
            cards
        }
        .padding()
    }
    
    struct CardView: View {
        @State var isFaceUp = true
        let content: String
        
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                
                Group {
                    base.foregroundColor(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(content).font(.largeTitle)
                }
                .opacity(isFaceUp ? 1 : 0)
                base.fill().opacity(isFaceUp ? 0 : 1)
            }
            .onTapGesture {
                isFaceUp.toggle()
            }
        }
    }
    
    var cards: some View {
        LazyVGrid (columns: [GridItem(.adaptive(minimum: 85))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
}

#Preview {
    ContentView()
}
