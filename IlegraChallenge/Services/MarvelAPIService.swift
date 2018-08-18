//
//  MarvelAPIService.swift
//  IlegraChallenge
//
//  Created by Gabriella Barbieri on 18/08/18.
//  Copyright © 2018 gabi. All rights reserved.
//

import Alamofire
import Foundation
import RxCocoa
import RxSwift

class MarvelAPIService {
    private let disposeBag = DisposeBag()
    
    private var publicKey: String!
    private var privateKey: String!
    
    private var baseURL: URL? {
        return URL(string: "https://gateway.marvel.com/v1/public/characters")
    }
    
    // MARK: - RxSwift variables
    
    // Inputs
    var offsetIndex = BehaviorSubject<Int>(value: 0)
    
    // Outputs
    private var characters = PublishSubject<[Character]>()
    var character: Observable<[Character]> {
        return characters.asObserver()
    }
    
    private var charactersJSON = BehaviorSubject<[[String: Any]]>(value: [])

    init?() {
        guard let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist") else {
            // TODO: melhorar essa mensagem
            print("Could not locate APIKeys.plist file.")
            return nil
        }
        
        guard let keys = NSDictionary(contentsOfFile: path) else {
            print("Could not locate each key. Try checking the keys of your plist file")
            return nil
        }
        
        guard let publicKey = keys["publicKey"] as? String, let privateKey = keys["privateKey"] as? String else {
            print("Could not locate each key. Try checking the keys of your plist file")
            return nil
        }
        
        self.publicKey = publicKey
        self.privateKey = privateKey
        
        charactersJSON
            .map { $0.compactMap { Character($0) } }
            .bind(to: characters)
            .disposed(by: disposeBag)
        
        characters
            .subscribe(onNext: { character in
                print(character)
            })
            .disposed(by: disposeBag)
        
        bindOffset()
    }

}

// MARK: Request functions
extension MarvelAPIService {
    func bindOffset() {
        offsetIndex
            .subscribe(onNext: { [weak self] offset in
                guard let this = self else {
                    return
                }
                var finalParams = this.authParameters
                finalParams.updateValue(offset, forKey: "offset")
                guard let request = this.request(using: finalParams) else {
                        return
                }
                
                URLSession.shared.dataTask(with: request) { data, _, error in
                    guard let data = data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                        let jsonDict = json as? [String: Any] else {
                            if let error = error {
                                print(error)
                            }
                            return
                    }
                    
                    guard let jsonData = jsonDict["data"] as? [String: Any],
                        let results = jsonData["results"] as? [[String: Any]] else {
                            return
                    }
                    this.charactersJSON.onNext(results)
                }
                    .resume()
            })
            .disposed(by: disposeBag)
    }
    
    private func request(using parameters: [String: Any]) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "gateway.marvel.com"
        urlComponents.path = "/v1/public/characters"
        
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        guard let url = urlComponents.url else {
            print("Error creating request, url is nil")
            return nil
        }
        
        var request = URLRequest(url: url)
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        return request
    }
}

// MARK: - Parameters
extension MarvelAPIService {
    
    private var authParameters: [String: Any] {
        var timeStamp = Date().timeIntervalSince1970.description
        timeStamp.remove(at: String.Index(encodedOffset: 10))
        guard let hash = MD5(timeStamp + self.privateKey + self.publicKey),
            let apiKey = self.publicKey else {
            return [:]
        }
        return ["apikey": apiKey,
                "ts": timeStamp,
                "hash": hash]
        
    }
    
    func MD5(_ string: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        if let data = string.data(using: String.Encoding.utf8) {
            _ = data.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(data.count), &digest)
            }
        }
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    func serializeData(_ data: Data) -> [String: Any]? {
        guard let resultJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonDict = resultJSON as? [String: Any] else {
                return nil
        }
        return jsonDict
    }
    
}
