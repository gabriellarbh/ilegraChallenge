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
import RxOptional
import RxSwift

enum RequestType {
    case character, comic
}

class MarvelAPIService {
    private let disposeBag = DisposeBag()
    
    private var publicKey: String!
    private var privateKey: String!
    
    // MARK: - RxSwift variables
    // Inputs
    var offsetIndex = BehaviorSubject<Int>(value: 0)
    
    // Outputs
    private var characters = PublishSubject<[Character]>()
    
    private var charactersJSON = PublishSubject<[[String: Any]]>()
    private var responseJSON = PublishSubject<Data>()
    
    var characterLoaded: Observable<[Character]> {
        return characters.asObservable()
    }
    
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
        
        responseJSON
            .map { jsonData -> [[String: Any]]? in
                guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments),
                    let jsonDict = json as? [String: Any] else {
                    return nil
                }
                
                guard let jsonData = jsonDict["data"] as? [String: Any],
                    let results = jsonData["results"] as? [[String: Any]] else {
                        return nil
                }
                return results
            }
            .filterNil()
            .bind(to: charactersJSON)
            .disposed(by: disposeBag)
        
        charactersJSON
            .map { $0.compactMap { Character($0) } }
            .bind(to: characters)
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
                guard let request = this.request(type: .character, using: finalParams) else {
                        return
                }
                
                URLSession.shared.dataTask(with: request) { data, _, error in
                    if let data = data {
                        self?.responseJSON.onNext(data)
                    } else {
                        print(error?.localizedDescription ?? "")
                    }
                }
                    .resume()
            })
            .disposed(by: disposeBag)
    }
    
    private func request(type: RequestType, using parameters: [String: Any]) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        
        switch type {
        case .character:
            urlComponents.host = "gateway.marvel.com"
            urlComponents.path = "/v1/public/characters"
        case .comic:
            urlComponents.host = "gateway.marvel.com"
            urlComponents.path = "/v1/public/comics"
        }
        
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

// MARK: - Parameters for authentication
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
    
}
