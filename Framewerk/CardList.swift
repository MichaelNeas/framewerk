//
//  CardList.swift
//  Framewerk
//
//  Created by Michael Neas on 2/27/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import SwiftUI

struct CardList: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        List(self.viewModel.bank) { card in
            Text(card.question)
        }
    }
}

struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        CardList()
    }
}
