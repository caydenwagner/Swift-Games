//
//  AspectVGrid.swift
//  Set
//
//  Created by Cayden Wagner on 12/28/24.
//

import SwiftUI

struct AspectVGrid<ItemView: View>: View {
    var items: [SetModel.Card]
    var aspectRatio: CGFloat = 1
    var content: (SetModel.Card) -> ItemView
    
    init(_ items: [SetModel.Card], aspectRatio: CGFloat, @ViewBuilder content: @escaping (SetModel.Card) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { card in
                    content(card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            
            if (rowCount * height) < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1.0
        } while columnCount < count
        
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
