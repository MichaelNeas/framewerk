//
//  CardDetail.swift
//  Framewerk
//
//  Created by Michael Neas on 2/29/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct CardDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var card: Card
    @State var textHeight: CGFloat = 150
    @State var link: String
    
    var body: some View {
        Form {
            Section(header: CardDetailTitle(title: "Title")) {
                TextField("Title", text: $card.question)
                    .foregroundColor(Color(.systemGray4))
                    .padding()
            }
            Section(header:  CardDetailTitle(title: "Description")) {
                ScrollView {
                    TextView(placeholder: "Card Solution", text: $card.answer, minHeight: 100.0, calculatedHeight: $textHeight)
                        .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                        .padding()
                }
            }
            Section(header: CardDetailTitle(title: "Link")) {
                TextField("Link", text: $link)
                    .foregroundColor(Color(.systemGray4))
                    .padding()
            }
        }
        .background(Color(UIColor.systemGray)).edgesIgnoringSafeArea(.bottom)
        .navigationBarItems(trailing:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
            }
        )
        .navigationBarTitle($card.question.wrappedValue)
    }
}

struct CardDetailTitle: View {
    var title: String
    var body: some View {
        Text(title)
            .bold()
            .foregroundColor(.black)
            .font(.headline)
    }
}

struct CardDetail_Previews: PreviewProvider {
    static var previews: some View {
        CardDetail(card: Card.test, link: Card.test.link.absoluteString)
    }
}
