//
//  ContentViewModel.swift
//  Framewerk
//
//  Created by Michael Neas on 1/25/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var cards = [Card]()
    @Published var bank = [Card]()
    @Published var all = [Card]()
    private let cardStore: CardStore
    
    init(store: CardStore) {
        self.cardStore = store
        fetchCards()
    }
    
    func fetchCards() {
        let shuffled: [Card]
        if let cards: [Card] = cardStore.loadData(), !cards.isEmpty {
            shuffled = cards.shuffled()
            self.all = cards.sorted()
        } else if let framewerkData = cardStore.fetchLocalCards() {
            shuffled = framewerkData.allCards.shuffled()
            self.all = framewerkData.allCards.sorted()
        } else {
            return
        }
        self.cards = Array(shuffled.prefix(upTo: 10))
        self.bank = Array(shuffled.suffix(from: 10))
    }
    
    func removeCard() {
        cards.removeLast()
        addCard()
    }
    
    func indexOf(_ card: Card) -> Int {
        return cards.firstIndex(where: { $0 == card }) ?? -1
    }
    
    func addCard() {
        guard !bank.isEmpty else { return }
        cards.insert(bank.removeFirst(), at: 0)
    }
}
