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
            self.textLabel?.text = info?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        CacheService.shared.thumbnails
            .filter { $0.1.path == self.info?.image.path }
            .subscribe(onNext: { data, _ in
                DispatchQueue.main.async {
                    self.characterImageView.image = UIImage(data: data)
                }
            })
            .disposed(by: disposeBag)
    }
}
