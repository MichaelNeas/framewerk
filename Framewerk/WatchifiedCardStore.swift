//
//  WatchifiedCardStore.swift
//  Framewerk
//
//  Created by Michael Neas on 4/27/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import Foundation
import WatchConnectivity
import os.log

class WatchifiedCardStore: CardStore {
    private var session: WCSession?
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    override func save<T>(data: T) where T : Encodable {
        super.save(data: data)
        do {
            if WCSession.isSupported() {
                // updateApplicationContext used to store state between watch
                let data = try encoder.encode(data)
                try session?.updateApplicationContext(["data": data])
            }
        } catch {
            os_log("Error sending data to watch app context: %s", log: Log.app, type: .error, error.localizedDescription)
        }
    }
}

extension WatchifiedCardStore: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Update application context here
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
    }
    
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}
