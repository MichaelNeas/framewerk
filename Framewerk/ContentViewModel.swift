//
//  ContentViewModel.swift
//  Framewerk
//
//  Created by Michael Neas on 1/25/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import Combine
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var cards = [Card]()
    @Published var bank = [Card]()
    @Published var all = [Card]()
    
    private let cardStore: CardStore
    private var cardCancellable = [AnyCancellable]()
    
    init(store: CardStore) {
        self.cardStore = store
        fetchCards()
        cardCancellable = all.map({ card in
            card.publisher.sink(receiveValue: { print($0) })
        })
    }
    
    func refreshCards() {
        let shuffled = all.shuffled()
        self.cards = Array(shuffled.prefix(upTo: 10))
        self.bank = Array(shuffled.suffix(from: 10))
    }
    
    func fetchCards() {
        if let cards: [Card] = cardStore.loadData(), !cards.isEmpty {
            all = cards.sorted()
        } else if let framewerkData = cardStore.fetchLocalCards() {
            all = framewerkData.allCards.sorted()
            cardStore.save(data: all)
        } else {
            fatalError("No cards")
        }
        let shuffled = all.shuffled()
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
    
    deinit {
        cardCancellable.forEach({ $0.cancel() })
    }
}
