//
//  ContentView.swift
//  Framewerk
//
//  Created by Michael Neas on 1/24/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    var isLandscape: Bool {
        UIApplication.shared.windows
        .first?
        .windowScene?
        .interfaceOrientation
        .isLandscape ?? false
    }
    
    init() {
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().barTintColor = UIColor.systemGray
        UINavigationBar.appearance().backgroundColor = UIColor.systemGray
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "HelveticaNeue", size: 28)!, .foregroundColor: UIColor.black]
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        ForEach(self.viewModel.cards) { card in
                            CardView(card: card) {
                                withAnimation {
                                    self.viewModel.removeCard()
                                }
                            }
                            .stacked(at: self.viewModel.indexOf(card), in: self.viewModel.cards.count)
                        }
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height)
            }
            .navigationBarItems(trailing: Button(action: self.viewModel.fetchCards) {
                Image(systemName: "tornado")
                    .font(Font(UIFont(name: "HelveticaNeue", size: 28)!))
                    .foregroundColor(.black)
                    .padding(.bottom, 8)
            })
            .navigationBarTitle("🍎 Frameworks", displayMode: .inline)
            .background(Color(UIColor.systemGray)).edgesIgnoringSafeArea(.all)
        }
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
