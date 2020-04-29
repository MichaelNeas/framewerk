//
//  HostingController.swift
//  FramwerkWatch Extension
//
//  Created by Michael Neas on 4/27/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI
import WatchConnectivity

class HostingController: WKHostingController<ContentView> {
    let cardStore: CardStore
    let viewModel: HomeViewModel
    private var session: WCSession?
    
    override init() {
        cardStore = CardStore()
        viewModel = HomeViewModel(store: cardStore)
        super.init()
    }
    
    override func willActivate() {
        super.willActivate()
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    override var body: ContentView {
        return ContentView(viewModel: viewModel)
    }
}


extension HostingController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {

    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        guard let data = applicationContext["data"] as? Data else { return }
        guard let cards = try? cardStore.decoder.decode([Card].self, from: data) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.viewModel.all = cards
        }
        cardStore.save(data: cards)
    }
}
