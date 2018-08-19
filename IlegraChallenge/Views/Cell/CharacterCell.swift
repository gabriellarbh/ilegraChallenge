//
//  CharacterCell.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import RxSwift
import UIKit

class CharacterCell: UITableViewCell {
    private let disposeBag = DisposeBag()
    @IBOutlet private weak var characterImageView: UIImageView!
    
    private var imageCharacter: UIImage?
    
    var info: CharacterInfo? {
        didSet {
            guard let info = self.info else {
                return
            }
            self.textLabel?.text = info.name
            let url = "\(info.image.path)/standard_fantastic.\(info.image.extension)"
            characterImageView.download(image: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
