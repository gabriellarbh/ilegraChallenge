//
//  IlegraChallengeTests.swift
//  IlegraChallengeTests
//
//  Created by Gabriella Barbieri on 17/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

@testable import IlegraChallenge
import RxSwift
import XCTest

class IlegraChallengeTests: XCTestCase {
    private let service = MarvelAPIService()
    private let disposeBag = DisposeBag()
    private var characterObservable: Observable<[IlegraChallenge.Character]>!
    
    override func setUp() {
        super.setUp()
        guard let service = service else {
            return
        }
        characterObservable = service.characterLoaded
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMarvelAPILimitLoading() {
        guard let service = service else {
            XCTAssert(false, "Service is nil")
            return
        }
        
        let offsetObs = service.offsetIndex
        
        characterObservable
            .subscribe(onNext: { characters in
                XCTAssert(characters.count == 20, "Is not downloading limit")
            })
            .disposed(by: disposeBag)
        
        offsetObs.onNext(0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
