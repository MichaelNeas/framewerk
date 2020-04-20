//
//  TutorialView.swift
//  Framewerk
//
//  Created by Michael Neas on 4/15/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct TutorialView: View {
    var closeAction: ()->()
    var TutorialCard: CardView
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer(minLength: 40.0)
                HStack {
                    Image(systemName: "square.stack.3d.up")
                        .font(FramewerkStyle.bigFont.font)
                        .foregroundColor(.black)
                        .accessibility(label: Text("List Cards"))
                    Text("See all cards, update, add, or delete as you please!").font(FramewerkStyle.bigFont.font).foregroundColor(.black)
                }.padding()
                HStack {
                    Image(systemName: "goforward")
                        .font(FramewerkStyle.bigFont.font)
                        .foregroundColor(.black)
                        .accessibility(label: Text("Refresh List"))
                    Text("Refresh the cards list!").font(FramewerkStyle.bigFont.font).foregroundColor(.black)
                }.padding()
                self.TutorialCard
                Spacer(minLength: 100.0)
                Button(action: {
                    self.closeAction()
                }, label: {
                    Text("Dismiss")
                        .font(FramewerkStyle.bigFont.font)
                        .foregroundColor(Color(UIColor.black))
                })
                Spacer(minLength: 40.0)
            }.padding().frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .background(Color(UIColor.systemTeal.withAlphaComponent(0.97)))
        .edgesIgnoringSafeArea(.all)
    }
}
