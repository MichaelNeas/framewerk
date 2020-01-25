//
//  ContentView.swift
//  Framewerk
//
//  Created by Michael Neas on 1/24/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var cards = [Card](repeating: Card.accelerate, count: 10)
    
    var body: some View {
        VStack {
            Text("🍎 Frameworks")
                .font(.largeTitle)
                .padding(.top, 50)
            Spacer()
            ZStack {
                VStack {
                    ZStack {
                        ForEach(0..<cards.count, id: \.self) { index in
                            CardView(card: self.cards[index]) {
                               withAnimation {
                                   self.removeCard(at: index)
                               }
                            }
                            .stacked(at: index, in: self.cards.count)
                        }
                    }
                }
            }
            Spacer()
            Spacer()
        }.background(Color.orange).edgesIgnoringSafeArea(.all)
    }
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 5))
    }
}
