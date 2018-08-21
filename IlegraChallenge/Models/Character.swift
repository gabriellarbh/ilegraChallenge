//
//  Character.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import Foundation
import RxSwift
import UIKit
// swiftlint:disable discouraged_optional_collection
class Character: Decodable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: Image
    var items: [Item]?

    init?(_ dict: [String: Any]) {
        let decoder = JSONDecoder()
        if let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
            let character = try? decoder.decode(Character.self, from: data) {
            self.id = character.id
            self.name = character.name
            self.description = character.description
            self.thumbnail = character.thumbnail
            if let comics = dict["comics"] as? [String: Any],
                let items = comics["items"] as? [[String: Any]] {
                self.items = items.compactMap { item in
                    if let name = item["name"] as? String, let resource = item["resourceURI"] as? String {
                        let trimmedResource = String(resource.dropFirst(7))
                        return Item(resourceURI: trimmedResource, name: name)
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
