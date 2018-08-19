//
//  CharactersDetailsViewModel.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import RxSwift

class CharactersDetailViewModel {
    private let disposeBag = DisposeBag()
    private var coordinator: AppCoordinator!
    
    private var characterSubject = ReplaySubject<Character>.create(bufferSize: 1)
    
    var characterImage = PublishSubject<UIImage?>()

    init(_ coordinator: AppCoordinator, character: Character) {
        self.coordinator = coordinator
        self.characterSubject.onNext(character)
    }
    
}

extension CharactersDetailViewModel {
    var characterName: Observable<String> {
        return characterSubject.map { $0.name }
    }
    
    var characterDescription: Observable<String> {
        return characterSubject.map { $0.description }
    }
    
    var imageURL: Observable<String> {
        return characterSubject.map { $0.thumbnail.toURL() }
    }
}
