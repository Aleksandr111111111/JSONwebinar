//
//  NetworService.swift
//  JSONwebinar
//
//  Created by Aleksander Kulikov on 18.03.2021.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print ("some error")
//                    completion(nil, error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
//                let somString = String(data: data, encoding: .utf8)
//                print(somString ?? " no data")
                completion(.success(data))
            }
        } .resume()
    }
    
    
    
}
