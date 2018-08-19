//
//  CharactersViewModel.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift

class CharactersViewModel {
    private let disposeBag = DisposeBag()
    private var coordinator: AppCoordinator!
    
    // View input
    var charactersInfo = PublishSubject<[SectionOfCharacterInfo]>()
    
    var didSelectCharacter = PublishSubject<Int>()
    
    init(_ coordinator: AppCoordinator) {
        self.coordinator = coordinator
        CacheService.shared.characters
            .map { $0.map { CharacterInfo(name: $0.name, image: $0.thumbnail, id: $0.id) } }
            .map { [SectionOfCharacterInfo(items: $0)] }
            .bind(to: charactersInfo)
            .disposed(by: disposeBag)
        
        didSelectCharacter
            .withLatestFrom(CacheService.shared.characters) { index, characters -> Character in
                characters[index]
            }
            .bind(to: coordinator.didSelectCharacter)
            .disposed(by: disposeBag)
        
    }
}
