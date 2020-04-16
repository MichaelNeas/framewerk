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
    @State var initialOffset: CGFloat = -1000.0
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
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        if self.viewModel.cards.isEmpty {
                            withAnimation{
                                Text("🤩 Woohoo! 🥳").font(Font(UIFont(name: "HelveticaNeue-Bold", size: 24)!))
                            }
                        }
                        ForEach(self.viewModel.cards) { card in
                            CardView(card: card) {
                                withAnimation {
                                    self.viewModel.removeCardFromStack()
                                }
                            }
                            .allowsHitTesting(card == self.viewModel.cards.last)
                            .stacked(at: self.viewModel.indexOf(card), in: self.viewModel.cards.count, initialOffset: self.initialOffset)
                        }
                    }
                    .onAppear {
                        withAnimation(Animation.spring()) {
                            self.initialOffset = 0.0
                        }
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height)
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
        .overlay(Tutorial().isHidden($tutorial.wrappedValue))
    }
}

extension View {
    func isHidden(_ hide: Bool) -> some View {
        hide ? AnyView(self.hidden()) : AnyView(self)
    }
    
    func stacked(at position: Int, in total: Int, initialOffset: CGFloat) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: initialOffset, height: -(1/offset) * 50))
    }
}
