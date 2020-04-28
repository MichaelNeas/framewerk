//
//  HomeViewModel.swift
//  Framewerk
//
//  Created by Michael Neas on 1/25/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI
import WatchConnectivity

class HomeViewModel: NSObject, ObservableObject {
    @Published var cards = [Card]()
    @Published var bank = [Card]()
    @Published var all = [Card]() {
        didSet {
            shuffle()
        }
    }
    @Published var offsets: [CGFloat] = [CGFloat]()
    
    private let cardStore: CardStore
    
    init(store: CardStore) {
        self.cardStore = store
        super.init()
        fetchCards()
    }
    
    func refreshCards() {
        shuffle()
        updateOffsets()
        //resetGame()
    }
    
    private func shuffle() {
        let shuffled = all.shuffled()
        self.cards = Array(shuffled.prefix(upTo: min(shuffled.count, 10)))
        self.bank = Array(shuffled.suffix(from: min(shuffled.count, 10)))
        self.offsets = Array(repeating: CGFloat(-1000.0), count: self.cards.count)
    }
    
    private func fetchCards() {
        if let cards: [Card] = cardStore.loadData(), !cards.isEmpty {
            all = cards.sorted()
        } else if let framewerkData = cardStore.fetchLocalCards() {
            all = framewerkData.allCards.sorted()
            save()
        } else {
            fatalError("No cards")
        }
    }
    
    func updateOffsets() {
        for index in 0..<offsets.count {
            // workaround for ForEach animations not working
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(index)) {
                self.offsets[index] = 0
            }
        }
    }
    
    func save() {
        cardStore.save(data: all)
    }
    
    func clearAll() {
        all.removeAll()
        bank.removeAll()
        cards.removeAll()
        save()
    }
    
    // this will reset the locally saved cards
    func resetGame() {
        if let framewerkData = cardStore.fetchLocalCards() {
            all = framewerkData.allCards.sorted()
            cardStore.save(data: all)
        }
    }
    
    func remove(at set: IndexSet) {
        all.remove(atOffsets: set)
        refreshCards()
        save()
    }
    
    func add(card: Card) {
        all.insert(card, at: 0)
        bank.append(card)
        refreshCards()
        save()
    }
    
    func indexOf(_ card: Card) -> Int {
        cards.firstIndex(where: { $0 == card }) ?? -1
    }
    
    func removeCardFromStack() {
        cards.removeLast()
        addCardToStack()
    }
    
    func addCardToStack() {
        guard !bank.isEmpty else { return }
        cards.insert(bank.removeFirst(), at: 0)
    }
}
