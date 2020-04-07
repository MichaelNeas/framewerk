//
//  CardList.swift
//  Framewerk
//
//  Created by Michael Neas on 2/27/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct CardList: View {
    @Environment(\.editMode) var editMode: Binding<EditMode>?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var cards: [Card]
    @State private var clearAllAlert = false
    @State private var showNewCard = false
    
    var body: some View {
        List {
            if editMode?.wrappedValue.isEditing ?? false {
                HStack {
                    Spacer()
                    Button(action: {
                        self.showNewCard = true
                    }) {
                        Text("Add New")
                            .font(Font(UIFont(name: "HelveticaNeue", size: 18)!))
                            .bold()
                            .foregroundColor(Color(UIColor.systemGreen))
                    }.sheet(isPresented: $showNewCard) {
                        CardDetail(card: Card.blank, link: "")
                    }
                    Spacer()
                    Button(action: {
                        self.clearAllAlert = true
                    }) {
                        Text("Clear All")
                            .font(Font(UIFont(name: "HelveticaNeue", size: 18)!))
                            .bold()
                            .foregroundColor(Color(UIColor.systemPink))
                    }
                    .alert(isPresented: $clearAllAlert) {
                        Alert(title: Text("Woah There!"), message: Text("Ready to start a new and delete all the cards in this list?"),
                            primaryButton: .cancel(Text("No Thanks!")),
                            secondaryButton: .destructive(Text("Make it so!"), action: deleteAll))
                    }
                    Spacer()
                }.buttonStyle(BorderlessButtonStyle())
            }
            ForEach(self.cards, id: \.id) { card in
                NavigationLink(destination: CardDetail(card: card, link: card.link.absoluteString)) {
                        Text(card.question)
                    }
            }.onDelete(perform: delete)
        }.foregroundColor(.black)
        .navigationBarTitle("Cards", displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "rectangle.stack")
                .font(Font(UIFont(name: "HelveticaNeue", size: 24)!))
                .padding(.bottom, 8)
        }, trailing: EditButton())
    }
    
    func deleteAll() {
        cards.removeAll()
    }
    
    func delete(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
    }
}
