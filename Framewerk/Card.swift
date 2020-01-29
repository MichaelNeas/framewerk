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
    let graphicsAndGames: [Card]
    let system: [Card]
    
    var allCards: [Card] {
        appFrameworks + graphicsAndGames + system
    }
}

struct Card: Codable, Identifiable, Equatable {
    let id = UUID()
    let question: String
    let answer: String
    let link: URL
}
