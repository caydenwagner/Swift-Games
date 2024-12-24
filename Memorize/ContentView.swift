//
//  ContentView.swift
//  Memorize
//
//  Created by Cayden Wagner on 12/17/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻","🎃","🍭","🕷️","👻","🎃","🍭","🕷️","👻","🎃","🍭","🕷️","👻","🎃","🍭","🕷️"]
    
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            cardCountAdjusters
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
        LazyVGrid (columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(00..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func cardCountAdjuster(by offset: Int, icon: String, label: String? = nil) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: icon)
            if let label = label {
                Text(label)
            }
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardCountAdjuster(by: -1, icon: "minus.circle", label: "Remove Card")
            Spacer()
            cardCountAdjuster(by: 1, icon: "plus.circle", label: "Add Card")
        }
        .imageScale(.large)
        .font(.title3)
    }
}

#Preview {
    ContentView()
}
