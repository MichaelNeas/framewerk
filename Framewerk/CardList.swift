//
//  CardList.swift
//  Framewerk
//
//  Created by Michael Neas on 2/27/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct CardList: View {
    var cards: [Card]
    
    init(cards: [Card]){
        self.cards = cards.sorted()
    }
    
    var body: some View {
        List(self.cards) { card in
            Text(card.question)
            .listRowBackground(Color(UIColor.systemGray))
        }
        .navigationBarTitle("Cards", displayMode: .inline)
    }
}

struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        CardList(cards: [])
    }
}
