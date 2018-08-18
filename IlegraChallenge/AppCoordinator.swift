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
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        return Observable.never()
    }
}
