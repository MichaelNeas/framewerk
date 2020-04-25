//
//  CardStore.swift
//  Framewerk
//
//  Created by Michael Neas on 4/4/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import Foundation
import os.log

class CardStore {
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
    
    func getDocumentsDirectory(with component: Directory?) -> URL {
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
        } catch {
            os_log("Error writing data: %s", log: Log.app, type: .error, error.localizedDescription)
        }
    }
    
    func sharedGroupDirectory(with component: Directory?) -> URL {
        let path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "framewerk")!
        guard let pathComponent = component else { return path }
        return path.appendingPathComponent(pathComponent.description)
    }
    
    // Save to group directory for watch extensions to use the same cards created by ios App
    func saveShared<T: Encodable>(data: T) {
        do {
            let data = try encoder.encode(data)
            try data.write(to: sharedGroupDirectory(with: .cards))
        } catch {
            os_log("Error writing data: %s", log: Log.app, type: .error, error.localizedDescription)
        }
    }
    
    // Load from the shared group
    func loadShared<T: Decodable>() -> [T]? {
        guard let data = try? Data(contentsOf: sharedGroupDirectory(with: .cards)) else { return nil }
        return try? decoder.decode([T].self, from: data)
    }

    
    
    func fetchLocalCards() -> FramewerkCardData? {
        guard let localJSONURL = Bundle.main.url(forResource: Directory.db.description, withExtension: "json"),
            let jsonData = try? Data(contentsOf: localJSONURL) else { return nil }
        return try? decoder.decode(FramewerkCardData.self, from: jsonData)
    }
}
