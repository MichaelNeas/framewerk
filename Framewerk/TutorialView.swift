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
        VStack(alignment: .center, spacing: 10.0) {
            Spacer(minLength: 40.0)
            HStack {
                Image(systemName: "square.stack.3d.up")
                    .font(FramewerkStyle.bigFont.font)
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.5)
                    .accessibility(label: Text("List Cards"))
                Text("See all cards, update, add, or delete as you please!")
                    .font(FramewerkStyle.bigFont.font)
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.5)
            }
            HStack {
                Image(systemName: "goforward")
                    .font(FramewerkStyle.bigFont.font)
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.5)
                    .accessibility(label: Text("Refresh List"))
                Text("Refresh the cards list!")
                    .font(FramewerkStyle.bigFont.font)
                    .foregroundColor(.black)
                    .minimumScaleFactor(0.5)
            }
            self.TutorialCard
            Button(action: {
                self.closeAction()
            }, label: {
                Text("Dismiss")
                    .font(FramewerkStyle.bigFont.font)
                    .foregroundColor(Color(UIColor.black))
            })
        }.padding(.all, 20.0)
        .background(Color(UIColor.systemTeal.withAlphaComponent(0.97)))
        .edgesIgnoringSafeArea(.all)
    }
}
