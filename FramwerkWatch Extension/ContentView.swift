//
//  ContentView.swift
//  FramwerkWatch Extension
//
//  Created by Michael Neas on 4/27/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            if self.viewModel.cards.isEmpty {
                withAnimation{
                    VStack {
                        Text("🤩 Woohoo! 🥳")
                        Button(action: self.viewModel.localGame) {
                            Image(systemName: "goforward")
                                .foregroundColor(.black)
                                .accessibility(label: Text("Refresh List"))
                        }.background(Color.white)
                        .cornerRadius(8)
                    }
                }
            }
            ForEach(self.viewModel.cards) { card in
                CardView(card: card) {
                    withAnimation {
                        self.viewModel.removeCardFromStack()
                    }
                }
                .allowsHitTesting(card == self.viewModel.cards.last)
                .stacked(at: self.viewModel.indexOf(card), in: self.viewModel.cards.count, initialOffset: self.viewModel.offsets[self.viewModel.indexOf(card)])
            }
        }
        .onAppear {
            withAnimation {
                self.viewModel.updateOffsets()
            }
        }.padding(.top, 8)
    }
}
