//
//  CharacterDetailsView.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//
import RxCocoa
import RxSwift
import UIKit

class CharacterDetailsView: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: CharactersDetailViewModel!
    
    @IBOutlet private weak var characterImage: UIImageView!
    @IBOutlet private weak var characterDescription: UILabel!
    @IBOutlet private weak var characterTitle: UILabel!
    
    static func with(_ viewModel: CharactersDetailViewModel) -> CharacterDetailsView {
        let detailsController = CharacterDetailsView()
        detailsController.viewModel = viewModel
        return detailsController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.characterName
            .asDriver(onErrorJustReturn: "N/A")
            .drive(characterTitle.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.characterDescription.errorOnEmpty()
            .asDriver(onErrorJustReturn: "N/A")
            .drive(characterDescription.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.imageURL
            .subscribe(onNext: { [unowned self] url in
                self.characterImage.download(image: url)
            })
            .disposed(by: disposeBag)
    }

}
