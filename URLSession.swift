//
//  URLSession.swift
//  APITestApp
//
//  Created by Prince Embola on 03/10/2021.
//

import Foundation

extension URLSession {
    enum CustomError: Error {
        case invalidURL
        case invalidData
    }
    
    func  request< X : Codable > (url: URL?, expecting: X.Type, completion: @escaping (Result< X , Error >) -> Void) {
            guard let url = url else {
                completion(.failure(CustomError.invalidURL))
                return
            }
            
        let task = dataTask(with: url) { data, res,  err in
            guard let data = data else {
                if let err = err {
                    completion(.failure(err))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
