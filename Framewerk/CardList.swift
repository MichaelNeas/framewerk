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
    @ObservedObject var model: ContentViewModel
    @State private var clearAllAlert = false
    @State private var showNewCard = false
    
    var body: some View {
        VStack {
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
                        CardDetail(card: Card.blank, commited: { card in
                            print("Add me \(card)")
                            self.model.add(card: card)
                        }, isNewCard: true)
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
                            secondaryButton: .destructive(Text("Make it so!"), action: model.clearAll))
                    }
                    Spacer()
                }.buttonStyle(BorderlessButtonStyle())
                .padding(.top, 20.0)
                Divider()
            }
            List {
                ForEach(self.model.all, id: \.id) { card in
                    NavigationLink(destination: CardDetail(card: card, commited: { card in
                        print("Save me \(card)")
                        self.model.save()
                    })) {
                        Text(card.question)
                    }
                }.onDelete(perform: model.remove)
            }.foregroundColor(.black)
            .navigationBarTitle("Cards", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "rectangle.stack")
                    .font(Font(UIFont(name: "HelveticaNeue", size: 24)!))
                    .padding(.bottom, 8)
            }, trailing: EditButton())
        }.background(Color(UIColor.systemGray))
    }
}
