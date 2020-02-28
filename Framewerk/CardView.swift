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
    var removal: (() -> Void)?

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(
                        Color(UIColor.systemGray6)
                            .opacity(1 - Double(abs(self.offset.width / 500)) - Double(abs(self.offset.height / 500)))
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(UIColor.systemBlue))
                    )
                    .shadow(radius: 10)
                VStack {
                    Text(self.card.question)
                        .font(.largeTitle)
                        .foregroundColor(Color(UIColor() { (trait) -> UIColor in
                            trait.userInterfaceStyle == .dark ? .white : .black
                        }))
                        .lineLimit(1)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.3)

                    if self.isShowingAnswer {
                        Text(self.card.answer)
                            .font(.title)
                            .foregroundColor(.secondary)
                            .lineLimit(nil)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.5)
                            .frame(width: max(geometry.size.width - 500, 350) - 50, height: max(geometry.size.height/2, 250) - 100)
                            .transition(.opacity)
                        HStack {
                            Spacer()
                            Button(action: {
                                UIApplication.shared.open(self.card.link)
                            }) {
                                Image(systemName: "info.circle")
                                    .font(.title)
                                    .foregroundColor(Color(UIColor.systemIndigo))
                            }.transition(.opacity)
                        }
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
        CardView(card: Card(question: "Preview Question?", answer: "Preview Answer", link: URL(string: "google.com")!))
    }
}
