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
    let viewModel = HomeViewModel(store: CardStore())
    private var session: WCSession?
    
    override func willActivate() {
        super.willActivate()
        session = WCSession.default
        session?.delegate = self
        session?.activate()
    }
    
    override var body: ContentView {
        return ContentView(viewModel: viewModel)
    }
}


extension HostingController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated {
            print("activateddddd")
           // Update application context here
        }
        print("activate")
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("app context - \(applicationContext)")
    }
}
