//
//  AppDelegate.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 17/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import RxSwift
import UIKit
// swiftlint:disable all
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator!
    private let disposeBag = DisposeBag()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else {
            fatalError("Should not happen, window is initialized")
        }
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
            .subscribe()
            .disposed(by: disposeBag)
        
        return true
    }
}

