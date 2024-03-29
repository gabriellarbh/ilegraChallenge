//
//  CharactersView.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

struct SectionOfCharacterInfo: Equatable {
    
    static func == (lhs: SectionOfCharacterInfo, rhs: SectionOfCharacterInfo) -> Bool {
        return lhs.items == rhs.items
    }
    
    var items: [CharacterInfo]
}

struct CharacterInfo: Equatable, IdentifiableType {
    typealias Identity = Int
    
    var name: String
    var image: Image
    var id: Int
    
    var identity: Int {
        return id
    }
    
    static func == (lhs: CharacterInfo, rhs: CharacterInfo) -> Bool {
        return lhs.identity == rhs.identity
    }
}

extension SectionOfCharacterInfo: AnimatableSectionModelType {
    var identity: String {
        return ""
    }
    
    typealias Item = CharacterInfo
    
    init(original: SectionOfCharacterInfo, items: [Item]) {
        self = original
        self.items = items
    }
}

class CharactersView: UIViewController {
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: CharactersViewModel!
    
    static func with(_ viewModel: CharactersViewModel) -> CharactersView {
        let characterView = CharactersView()
        characterView.viewModel = viewModel
        return characterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CharacterRedCell", bundle: nil), forCellReuseIdentifier: "characterRedCell")
        tableView.register(UINib(nibName: "CharacterBlackCell", bundle: nil), forCellReuseIdentifier: "characterBlackCell")
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCharacterInfo>(configureCell: { _, table, indexPath, item in
            let identifier = indexPath.row % 2 == 0 ? "characterRedCell" : "characterBlackCell"
            if var cell = table.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CharacterCellProtocol {
                cell.info = item
                guard let tableViewCell = cell as? UITableViewCell else {
                    fatalError("CharacterCellProtocol is not being implemented by a UITableViewCell")
                }
                
                return tableViewCell
            } else {
                fatalError("Could not dequeue cell with identifier \(identifier)")
            }
        })
        
        viewModel.charactersInfo
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.didSelectCharacter)
            .disposed(by: disposeBag)
        
        tableView.rx.didScroll
            .bind(to: viewModel.didScroll)
            .disposed(by: disposeBag)
        self.title = "Character List"
    }
}
