//
//  File.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 19/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import Kingfisher
import UIKit

extension UIImageView {
    func download(image url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        self.kf.setImage(with: ImageResource(downloadURL: imageURL))
    }
}
