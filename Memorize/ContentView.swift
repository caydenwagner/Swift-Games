//
//  ContentView.swift
//  Memorize
//
//  Created by Cayden Wagner on 12/17/24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🍭", "🕷️"]
    
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
        .padding()
        
    }
}

struct CardView: View {
    @State var isFaceUp = true
    let content: String
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            if (isFaceUp) {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            else {
                base.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
