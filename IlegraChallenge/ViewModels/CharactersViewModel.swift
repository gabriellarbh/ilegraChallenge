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
    private var characters: [Character] = []
    // View input
    var charactersInfo = PublishSubject<[SectionOfCharacterInfo]>()
    
    var didSelectCharacter = PublishSubject<Int>()
    var didScroll = PublishSubject<Void>()
    
    init(_ coordinator: AppCoordinator) {
        self.coordinator = coordinator
        CacheService.shared.characters
            .subscribe(onNext: { [unowned self] characters in
                self.characters.append(contentsOf: characters)
                let sections = [SectionOfCharacterInfo(items: self.characters.map { CharacterInfo(name: $0.name,
                                                                                                  image: $0.thumbnail,
                                                                                                  id: $0.id)
                })]
                self.charactersInfo.onNext(sections)
            })
            .disposed(by: disposeBag)
        
        didSelectCharacter
            .subscribe(onNext: { [unowned self] index in
                guard index < self.characters.count else {
                    return
                }
                let character = self.characters[index]
                self.coordinator.didSelectCharacter.onNext(character)
            })
            .disposed(by: disposeBag)
        
        didScroll
            .throttle(Double(3), latest: true, scheduler: MainScheduler.instance)
            .bind(to: CacheService.shared.shouldLoadCharacters)
            .disposed(by: disposeBag)
    }
}
