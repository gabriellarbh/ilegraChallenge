//
//  AppCoordinator.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import RxSwift
import UIKit

class AppCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow!
    var didSelectCharacter = PublishSubject<Character>()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = CharactersViewModel(self)
        let viewController = CharactersView.with(viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        didSelectCharacter
            .subscribe(onNext: { character in
                let viewModel = CharactersDetailViewModel(self, character: character)
                let viewController = CharacterDetailsView.with(viewModel)
                navController.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        return Observable.never()
    }
}
