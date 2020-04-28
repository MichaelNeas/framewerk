//
//  FramewerkStyle.swift
//  Framewerk
//
//  Created by Michael Neas on 4/19/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct FramewerkStyle {
    static let massiveFont = UIFont(name: "HelveticaNeue", size: 26)!
    static let bigFont = UIFont(name: "HelveticaNeue", size: 24)!
    static let mediumFont = UIFont(name: "HelveticaNeue", size: 18)!
    static let smallFont = UIFont(name: "HelveticaNeue", size: 16)!
}

struct CardDetailTitle: View {
    var title: String
    var body: some View {
        Text(title)
            .bold()
            .foregroundColor(.black)
            .font(.headline)
    }
}

extension UIFont {
    var font: Font {
        Font(self)
    }
}

