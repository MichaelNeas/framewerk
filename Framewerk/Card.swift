//
//  Card.swift
//  Framewerk
//
//  Created by Michael Neas on 1/24/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import Foundation
import Combine

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

class Card: ObservableObject, Codable, Equatable, Identifiable, Comparable {
    let id = UUID()
    @Published var question: String
    @Published var answer: String
    @Published var link: URL
    @Published var favorite: Bool = false
    
    enum CodingKeys: CodingKey {
        case question, answer, link, favorite
    }
    
    init(question: String, answer: String, link: URL) {
        self.question = question
        self.answer = answer
        self.link = link
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        question = try container.decode(String.self, forKey: .question)
        answer = try container.decode(String.self, forKey: .answer)
        link = try container.decode(URL.self, forKey: .link)
        favorite = try container.decodeIfPresent(Bool.self, forKey: .favorite) ?? false
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(question, forKey: .question)
        try container.encode(answer, forKey: .answer)
        try container.encode(link, forKey: .link)
        try container.encode(favorite, forKey: .favorite)
    }
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        lhs.question < rhs.question
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
    
    static let test: Card = Card(question: "Test", answer: "test answer", link: URL(string: "mikeneas.com")!)
    static let blank: Card = Card(question: "", answer: "", link: URL(string: "mikeneas.com")!)
}
