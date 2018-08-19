//
//  CharacterRedCell.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 19/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import UIKit

class CharacterRedCell: UITableViewCell, CharacterCellProtocol {
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var info: CharacterInfo? {
        didSet {
            guard let info = self.info else {
                return
            }
            self.titleLabel.text = info.name
            let url = "\(info.image.path)/standard_fantastic.\(info.image.extension)"
            characterImageView.download(image: url)
            self.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
