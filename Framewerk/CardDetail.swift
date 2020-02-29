//
//  CardDetail.swift
//  Framewerk
//
//  Created by Michael Neas on 2/29/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct CardDetail: View {
    @ObservedObject var card: Card
    @State var textHeight: CGFloat = 150
    @State var link: String = ""
    
    init(card: Card) {
        self.card = card
        self.link = card.link.absoluteString
    }
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Title", text: $card.question)
            }
            Section(header: Text("Description")) {
                ScrollView {
                    TextView(placeholder: "Card Solution", text: $card.answer, minHeight: 100.0, calculatedHeight: $textHeight)
                }.frame(minHeight: self.textHeight, maxHeight: self.textHeight)
            }
            Section(header: Text("Link")) {
                TextField("Link", text: $link)
            }
        }.background(Color(UIColor.systemGray)).edgesIgnoringSafeArea(.bottom)
    }
}

struct CardDetail_Previews: PreviewProvider {
    static var previews: some View {
        CardDetail(card: Card.test)
    }
}
