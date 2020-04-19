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
    @State private var showDocumentation = false
    
    @ObservedObject var card: Card
    @ObservedObject var model: ContentViewModel
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
                        .lineLimit(nil)
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
                            Button(action: {
                                self.card.favorite.toggle()
                                self.model.save()
                            }) {
                                Image(systemName: self.card.favorite ? "star.fill" : "star")
                                    .font(.title)
                                    .foregroundColor(Color(UIColor.systemIndigo))
                            }
                            Spacer()
                            Button(action: {
                                self.showDocumentation = true
                            }) {
                                Image(systemName: "info.circle")
                                    .font(.title)
                                    .foregroundColor(Color(UIColor.systemIndigo))
                            }.transition(.opacity)
                            .sheet(isPresented: self.$showDocumentation) {
                                WebView(request: URLRequest(url: self.card.link))
                            }
                        }
                    }
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .frame(width: max(geometry.size.width - 500, 350), height: max(geometry.size.height/2, 250))
            .rotationEffect(.degrees(Double(self.offset.width / 10)))
            .animation(.spring())
            .offset(self.offset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset = gesture.translation
                    }
                    .onEnded { gesture in
                        if (abs(self.offset.width) > 150 ||
                            abs(self.offset.height) > 150) ||
                            abs(gesture.predictedEndTranslation.width) > 200 ||
                            abs(gesture.predictedEndTranslation.height) > 200,
                            self.removal != nil {
                            self.removal?()
                        } else {
                            self.offset = .zero
                        }
                    }
            )
            .onTapGesture {
                self.isShowingAnswer.toggle()
            }
        }
    }
}
