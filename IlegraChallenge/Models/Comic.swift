//
//  Comic.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import Foundation

struct Comic: Decodable {
    let id: Int
    let title: String
    let issueNumber: Int
    let description: String
    let isbn: String
}

struct Item: Decodable {
    let resourceURI: String
    let name: String
}
