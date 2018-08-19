//
//  CacheService.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class CacheService {
    static let shared = CacheService()
    
    private let disposeBag = DisposeBag()
    private let apiService = MarvelAPIService()
    
    private var nextIndex = 0
    
    // Inputs
    var shouldLoadCharacters = PublishSubject<Void>()
    
    // Outputs
    private var loadedCharacter = PublishSubject<[Character]>()
    private var loadedThumbnails = PublishSubject<(Data, Image)>()
    
    var characters: Observable<[Character]> {
        return loadedCharacter.asObservable()
    }
    
    var thumbnails: Observable<(Data, Image)> {
        return loadedThumbnails.asObservable()
    }

    init() {
        guard let apiService = self.apiService else {
            fatalError("API Service is nil")
        }
        
        apiService.characterLoaded.bind(to: loadedCharacter).disposed(by: disposeBag)
        apiService.thumbnailLoaded.bind(to: loadedThumbnails).disposed(by: disposeBag)
        
        shouldLoadCharacters
            .map { [weak self] _ -> Int in
                guard let this = self else {
                    return -1
                }
                this.nextIndex += 1
                return this.nextIndex * 20
            }
            .filter { $0 >= 0 }
            .bind(to: apiService.offsetIndex)
            .disposed(by: disposeBag)
    }
}
