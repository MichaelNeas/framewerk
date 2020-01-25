//
//  ContentView.swift
//  Framewerk
//
//  Created by Michael Neas on 1/24/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var cards = [Card](repeating: Card.accelerate, count: 50)
    
    var isLandscape: Bool {
        UIApplication.shared.windows
        .first?
        .windowScene?
        .interfaceOrientation
        .isLandscape ?? false
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer(minLength: self.isLandscape ? 6 : 50)
                Text("🍎 Frameworks")
                    .font(.largeTitle)
                Spacer()
                ZStack {
                    VStack {
                        ZStack {
                            ForEach(0..<self.cards.count, id: \.self) { index in
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
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
        .background(Color(UIColor.systemOrange)).edgesIgnoringSafeArea(.all)
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
        return self.offset(CGSize(width: 0, height: -(1/offset) * 50))
    }
}
