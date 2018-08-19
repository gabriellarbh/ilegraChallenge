//
//  AppCoordinator.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import RxSwift
import UIKit
import UINavigationBar_Transparent

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
        navController.navigationBar.barStyle = .black
        navController.navigationBar.tintColor = .white
        navController.navigationBar.titleTextAttributes = [kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.white]
        navController.navigationBar.setBarColor(UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.5))
        
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
