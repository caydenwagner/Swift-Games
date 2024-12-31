//
//  ContentView.swift
//  Set
//
//  Created by Cayden Wagner on 12/29/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SetViewModel()
        
    var body: some View {
        SetView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
