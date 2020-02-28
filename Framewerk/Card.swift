//
//  Card.swift
//  Framewerk
//
//  Created by Michael Neas on 1/24/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import Foundation

struct FramewerkCardData: Codable {
    let appFrameworks: [Card]
    let appServices: [Card]
    let developerTools: [Card]
    let graphicsAndGames: [Card]
    let media: [Card]
    let system: [Card]
    let web: [Card]
    
    var allCards: [Card] {
        appFrameworks + appServices + developerTools + graphicsAndGames + media + system + web
    }
}

struct Card: Codable, Identifiable, Equatable, Comparable {
    let id = UUID()
    let question: String
    let answer: String
    let link: URL
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        lhs.question < rhs.question
    }
}
