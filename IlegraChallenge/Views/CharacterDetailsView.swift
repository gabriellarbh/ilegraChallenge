//
//  CharacterDetailsView.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class CharacterDetailsView: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: CharactersDetailViewModel!
    
    @IBOutlet private weak var characterImage: UIImageView!
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var comicsTableView: UITableView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    private var infoHeight: CGFloat {
        return descriptionLabel.frame.height + nameLabel.frame.height
    }
    
    static func with(_ viewModel: CharactersDetailViewModel) -> CharacterDetailsView {
        let detailsController = CharacterDetailsView()
        detailsController.viewModel = viewModel
        return detailsController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsTableView.register(UINib(nibName: "ComicCell", bundle: nil), forCellReuseIdentifier: "comicTitleCell")
        characterImage.layer.cornerRadius = characterImage.frame.width / 2
        characterImage.clipsToBounds = true
        characterImage.layer.borderColor = UIColor(red: 187 / 255.0, green: 28 / 255.0, blue: 18 / 255.0, alpha: 1).cgColor
        characterImage.layer.borderWidth = 7.0
        
        scrollView.rx.contentOffset
            .map { point in point.y >= self.infoHeight / 2 }
            .asDriver(onErrorJustReturn: true)
            .drive(comicsTableView.rx.isScrollEnabled)
            .disposed(by: disposeBag)
        
        viewModel.characterName
            .asDriver(onErrorJustReturn: "N/A")
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.characterDescription.errorOnEmpty()
            .asDriver(onErrorJustReturn: "N/A")
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.imageURL
            .subscribe(onNext: { [unowned self] url in
                self.characterImage.download(image: url)
            })
            .disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<CharacterDetailsSection>(configureCell: { _, tableView, indexPath, item in
            if let cell = tableView.dequeueReusableCell(withIdentifier: "comicTitleCell", for: indexPath) as? ComicCell {
                cell.textLabel?.text = item
                return cell
            } else {
                fatalError("Could not dequeue reusable cell with 'comicTitleCell'")
            }
        })
        
        viewModel.comicsAppearance
            .bind(to: comicsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}

struct CharacterDetailsSection: Equatable {
    
    var items: [String]
    
    static func == (lhs: CharacterDetailsSection, rhs: CharacterDetailsSection) -> Bool {
        return lhs.items == rhs.items
    }
}

extension CharacterDetailsSection: SectionModelType {
    init(original: CharacterDetailsSection, items: [String]) {
        self = original
        self.items = items
    }
}
