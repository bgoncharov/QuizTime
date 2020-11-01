//
//  JsonDataFetcher.swift
//  TandemCodeChallenge
//
//  Created by Boris Goncharov on 10/26/20.
//

import Foundation

class JsonDataFetcher {
    func fetchQuestions(completion: @escaping (Result<[Question], Error>) -> Void) {
        
        let urlString = Bundle.main.url(forResource: "jsonData", withExtension: "json")!

        do {
            let data = try Data(contentsOf: urlString)
            
            decodeJSON(type: [Question].self, with: data) { (result) in
                switch result {
                
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, with data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let object = try JSONDecoder().decode(type.self, from: data)
            completion(.success(object))
        } catch let jsonError {
            completion(.failure(jsonError))
        }
    }
}
