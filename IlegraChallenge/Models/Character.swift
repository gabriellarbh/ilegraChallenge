//
//  Character.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Image
    
    let appearsIn: [Comic]?
    let items: [Item]?
    
    // TODO: Find a better way to do this
    init?(_ dict: [String: Any]) {
        let decoder = JSONDecoder()
        if let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
            let character = try? decoder.decode(Character.self, from: data){
            self.id = character.id
            self.name = character.name
            self.description = character.description
            self.thumbnail = character.thumbnail
            
            if let comics = dict["comics"] as? [String: Any],
                let items = comics["items"] as? [[String: Any]] {
                self.items = items.compactMap { item in
                    if let name = item["name"] as? String, let resource = item["resourceURI"] as? String {
                        return Item(resourceURI: resource, name: name)
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return nil
        }
    }
}
