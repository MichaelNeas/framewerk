//
//  CardStore.swift
//  Framewerk
//
//  Created by Michael Neas on 4/4/20.
//  Copyright © 2020 Neas Lease. All rights reserved.
//

import Foundation

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
            try data.write(to: getDocumentsDirectory(with: .cards), options: [.atomicWrite, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchLocalCards() -> FramewerkCardData? {
        guard let localJSONURL = Bundle.main.url(forResource: Directory.db.description, withExtension: "json"),
            let jsonData = try? Data(contentsOf: localJSONURL) else { return nil }
        return try? decoder.decode(FramewerkCardData.self, from: jsonData)
    }
}