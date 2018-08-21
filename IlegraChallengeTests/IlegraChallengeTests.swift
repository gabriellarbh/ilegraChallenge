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
    private var data: Data!
    override func setUp() {
        super.setUp()
        guard let service = service else {
            return
        }
        characterObservable = service.characterLoaded

        guard let path = Bundle.main.path(forResource: "mock", ofType: "JSON") else {
            return
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return
        }
        self.data = data
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

    func testCharacterParsing() {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            XCTAssert(false, "data is not json")
            return
        }

        guard let jsondict = json as? [String: Any] else {
            XCTAssert(false, "JSON is not dictionary")
            return
        }

        let character = IlegraChallenge.Character(jsondict)
        XCTAssertNotNil(character, "Character is nil from valid JSON")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
