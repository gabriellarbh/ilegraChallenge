//
//  File.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 19/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import UIKit

protocol CharacterCellProtocol where Self: UITableViewCell {
    var info: CharacterInfo? { get set }
}
