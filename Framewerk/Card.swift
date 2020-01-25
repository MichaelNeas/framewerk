//
//  Card.swift
//  Framewerk
//
//  Created by Michael Neas on 1/24/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import Foundation

struct Card {
    let question: String
    let answer: String

    static var accelerate: Card {
        return Card(question: "What is Accelerate?", answer: "Make large-scale mathematical computations and image calculations, optimized for high performance and low-energy consumption.")
    }
}
