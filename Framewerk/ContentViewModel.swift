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
    
    let decoder = JSONDecoder()
    var bank = [Card]()
    
    init() {
        fetchCards()
    }
    
    func fetchCards() {
        if let localJSONURL = Bundle.main.url(forResource: "db", withExtension: "json"),
            let jsonData = try? Data(contentsOf: localJSONURL),
            let framewerkData = try? decoder.decode(FramewerkCardData.self, from: jsonData) {
            let shuffled = framewerkData.allCards.shuffled()
            self.cards = Array(shuffled.prefix(upTo: 10))
            self.bank = Array(shuffled.suffix(from: 10))
        }
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
