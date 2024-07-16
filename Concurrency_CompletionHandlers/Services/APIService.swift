//
//  APIService.swift
//  Concurrency_CompletionHandlers
//
//  Created by RAMESH on 16/07/24.
//

import Foundation

enum APIError: Error,LocalizedError {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError(String)
    case corruptData
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("URLEnd Point is invalid", comment: "")
        case .invalidResponseStatus:
            return NSLocalizedString("API returned invalid Status code", comment: "")
        case .dataTaskError(let errorString):
            return errorString
        case .corruptData:
            return NSLocalizedString("Data corrupted", comment: "")
        case .decodingError(let errorString):
            return errorString
        }
    }
}
struct APIService {
    let urlString: String
    
    func getJSON<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                keyDecodingstrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            guard let response = response as? HTTPURLResponse ,response.statusCode == 200 else {
                completion(.failure(.invalidResponseStatus))
                return
            }
            guard error == nil else {
                completion(.failure(.dataTaskError(error!.localizedDescription)))
                return
            }
            guard let data = data else { completion(.failure(.corruptData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = dateDecodingStrategy
                decoder.keyDecodingStrategy = keyDecodingstrategy
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            }
            catch {
                completion(.failure(.decodingError(error.localizedDescription)))
                print("Error")
                return
            }
            
        }.resume()
    }
}
