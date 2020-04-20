//
//  CardDetail.swift
//  Framewerk
//
//  Created by Michael Neas on 2/29/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI
import os.log

struct CardDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var card: Card
    @State var textHeight: CGFloat = 150
    var commited: ((Card) -> ())?
    var isNewCard = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: CardDetailTitle(title: "Title")) {
                    TextField("Title", text: $card.question, onEditingChanged: changed, onCommit: commit)
                        .foregroundColor(Color(.systemGray4))
                        .padding()
                }
                Section(header:  CardDetailTitle(title: "Description")) {
                    ScrollView {
                        TextView(placeholder: "Card Solution", text: $card.answer, minHeight: 100.0, calculatedHeight: $textHeight, finished: commit)
                            .frame(minHeight: self.textHeight, maxHeight: self.textHeight)
                            .padding()
                    }
                }
                Section(header: CardDetailTitle(title: "Link")) {
                    TextField("Link", text: Binding(
                        get: {
                            self.card.link.absoluteString
                        },
                        set: { potentialURL in
                            guard let url = URL(string: potentialURL) else { return }
                            self.card.link = url
                        }), onEditingChanged: changed, onCommit: commit)
                        .foregroundColor(Color(.systemGray4))
                        .padding()
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                self.commited?(self.card)
            }) {
                Text("Save")
            })
        }
        .background(Color(UIColor.systemGray)).edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle(Text($card.question.wrappedValue), displayMode: .inline)
    }
    
    func changed(change: Bool) {
        if !change {
            commit()
        }
    }
    
    func commit(description: String) {
        card.answer = description
        commit()
    }
    
    // commit fires on 'done' and manually from change finishing
    func commit() {
        guard !isNewCard else { return }
        os_log("COMMIT changed card")
        commited?(card)
    }
}
