//
//  Card.swift
//  Framewerk
//
//  Created by Michael Neas on 1/24/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
    let id = UUID()
    let question: String
    let answer: String
}
