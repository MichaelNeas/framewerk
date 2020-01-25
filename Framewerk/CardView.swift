//
//  CardView.swift
//  Framewerk
//
//  Created by Michael Neas on 1/24/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct CardView: View {
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    let card: Card
    var removal: (() -> Void)? = nil

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(
                        Color(UIColor.systemGray6)
                            .opacity(1 - Double(abs(self.offset.width / 500)) - Double(abs(self.offset.height / 500)))
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(Color(UIColor.systemBlue))
                    )
                    .shadow(radius: 10)
                VStack {
                    Text(self.card.question)
                        .font(.largeTitle)

                    if self.isShowingAnswer {
                        Spacer()
                        Text(self.card.answer)
                            .font(.title)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .frame(width: max(geometry.size.width - 500, 350), height: max(geometry.size.height/2, 250))
            .rotationEffect(.degrees(Double(self.offset.width / 10)))
            .offset(x: self.offset.width, y: self.offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                    }

                    .onEnded { _ in
                        if abs(self.offset.width) > 150 || abs(self.offset.height) > 150 {
                            self.removal?()
                        } else {
                            self.offset = .zero
                        }
                    }
            ).animation(.spring())
            .onTapGesture {
                self.isShowingAnswer.toggle()
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.accelerate)
    }
}
