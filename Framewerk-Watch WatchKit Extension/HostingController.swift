//
//  HostingController.swift
//  Framewerk-Watch WatchKit Extension
//
//  Created by Michael Neas on 4/24/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<ContentView> {
    let viewModel = HomeViewModel(store: CardStore())
    
    override var body: ContentView {
        return ContentView(viewModel: viewModel)
    }
}