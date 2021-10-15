//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import Foundation

protocol NetworkType {
    func fetch<T: Decodable>(url: URL?, completion: @escaping (Result<T, Error>) -> Void)
    func fetch(url: URL?, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkManager {
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
}

extension NetworkManager: NetworkType {
    
    func fetch<T>(url: URL?, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        guard let url = url else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        self.session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badStatusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
        
        
    }
    
    func fetch(url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = url else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        self.session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badStatusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }
            
            completion(.success(data))
        }.resume()
        
    }
    
}
