//
//  Tutorial.swift
//  Framewerk
//
//  Created by Michael Neas on 4/15/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct Tutorial: View {
    var closeAction: ()->()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Text("Tap on the card list button to see all cards, update, add, or delete as you please!")
                    Spacer()
                    Text("Refresh the cards list")
                }
                Spacer()
                Text("Cards are swipe and tappable")
                    .frame(width: geo.size.width / 2, height: geo.size.height / 1.8)
                Spacer()
                Button(action: {
                    self.closeAction()
                }, label: {
                    Text("Dismiss")
                })
            }.frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            
        }
        .background(Color(UIColor.systemIndigo.withAlphaComponent(0.9)))
        .edgesIgnoringSafeArea(.all)
    }
}
