//
//  ContentView.swift
//  Framewerk-Watch WatchKit Extension
//
//  Created by Michael Neas on 4/24/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var showDocumentation = false
    
    @ObservedObject var card: Card
    var removal: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(
                        Color(red: 0.8, green: 0.8, blue: 0.8)
                            .opacity(1 - Double(abs(self.offset.width / 500)) - Double(abs(self.offset.height / 500)))
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color.blue)
                    )
                    .shadow(radius: 10)
                VStack {
                    Text(self.card.question)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .lineLimit(nil)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.3)

                    if self.isShowingAnswer {
                        Spacer()
                        Text(self.card.answer)
                            .font(.title)
                            .foregroundColor(Color(red: 0.4, green: 0.4, blue: 0.4))
                            .lineLimit(nil)
                            .allowsTightening(true)
                            .minimumScaleFactor(0.4)
                            .transition(.opacity)
                    }
                }
                .padding(20)
                .multilineTextAlignment(.center)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
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
