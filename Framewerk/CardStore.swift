//
//  CardStore.swift
//  Framewerk
//
//  Created by Michael Neas on 4/4/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import Foundation
import os.log

class CardStore: NSObject {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    enum Directory: CustomStringConvertible {
        case cards
        case db
        
        var description: String {
            switch self {
            case .cards: return "cards"
            case .db: return "db"
            }
        }
    }
    
    private func getDocumentsDirectory(with component: Directory?) -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let pathComponent = component else { return paths[0] }
        return paths[0].appendingPathComponent(pathComponent.description)
    }
    
    func loadData<T: Decodable>() -> [T]? {
        guard let data = try? Data(contentsOf: getDocumentsDirectory(with: .cards)) else { return nil }
        return try? decoder.decode([T].self, from: data)
    }
    
    func save<T: Encodable>(data: T) {
        do {
            let data = try encoder.encode(data)
            try data.write(to: getDocumentsDirectory(with: .cards), options: [.atomicWrite])
//            if WCSession.isSupported() {
//                // updateApplicationContext used to store state between watch
//                //try session?.updateApplicationContext(["data": data])
//            }
        } catch {
            os_log("Error writing data: %s", log: Log.app, type: .error, error.localizedDescription)
        }
    }
    
    func fetchLocalCards() -> FramewerkCardData? {
        guard let localJSONURL = Bundle.main.url(forResource: Directory.db.description, withExtension: "json"),
            let jsonData = try? Data(contentsOf: localJSONURL) else { return nil }
        return try? decoder.decode(FramewerkCardData.self, from: jsonData)
    }
}


//extension CardStore: WCSessionDelegate {
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//        if activationState == .activated {
//            print("activateddddd")
//           // Update application context here
//        }
//        print("activate")
//    }
//    
//    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
//        print("app context - \(applicationContext)")
//    }
//    
//    #if !os(watchOS)
//    func sessionDidBecomeInactive(_ session: WCSession) {
//        print("Inactive")
//    }
//    
//    func sessionDidDeactivate(_ session: WCSession) {
//        print("did deactivate")
//    }
//    #endif
//}
