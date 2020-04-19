//
//  ContentView.swift
//  Framewerk
//
//  Created by Michael Neas on 1/24/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var tutorial = UserDefaults.standard.bool(forKey: "tutorial")
    
    var isLandscape: Bool {
        UIApplication.shared.windows
        .first?
        .windowScene?
        .interfaceOrientation
        .isLandscape ?? false
    }
    
    init(model: ContentViewModel) {
        self.viewModel = model
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if self.viewModel.cards.isEmpty {
                    withAnimation{
                        Text("🤩 Woohoo! 🥳").font(Font(UIFont(name: "HelveticaNeue-Bold", size: 24)!))
                    }
                }
                ForEach(0..<self.viewModel.cards.count) { index in
                    CardView(card: self.viewModel.cards[index], model: self.viewModel) {
                        withAnimation {
                            self.viewModel.removeCardFromStack()
                        }
                    }
                    .allowsHitTesting(self.viewModel.cards[index] == self.viewModel.cards.last)
                    .stacked(at: index, in: self.viewModel.cards.count, initialOffset: self.viewModel.offsets[index])
                }
            }
            .onAppear {
                withAnimation {
                    self.viewModel.updateOffsets()
                }
            }
            .navigationBarItems(leading:
                NavigationLink(destination: CardList(model: viewModel)){
                Image(systemName: "square.stack.3d.up")
                    .font(Font(UIFont(name: "HelveticaNeue", size: 24)!))
                    .foregroundColor(.black)
                    .padding(.bottom, 8)
            }, trailing: Button(action: self.viewModel.refreshCards) {
                Image(systemName: "goforward")
                    .font(Font(UIFont(name: "HelveticaNeue", size: 24)!))
                    .foregroundColor(.black)
                    .padding(.bottom, 8)
            })
            .navigationBarTitle("Framewerk", displayMode: .inline)
            .background(Color(UIColor.systemGray)).edgesIgnoringSafeArea(.all)
        }.navigationViewStyle(StackNavigationViewStyle())
        .overlay(Tutorial(closeAction: {
            withAnimation {
                self.$tutorial.wrappedValue = true
            }
            UserDefaults.standard.set(true, forKey: "tutorial")
        }, TutorialCard: CardView(card: Card.tutorial, model: self.viewModel))
            .opacity($tutorial.wrappedValue ? 0 : 1))
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 1.4)))
    }
}
