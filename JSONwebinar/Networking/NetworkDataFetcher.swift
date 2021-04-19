//
//  NetworkDataFetcher.swift
//  JSONwebinar
//
//  Created by Aleksander Kulikov on 26.03.2021.
//

import Foundation


class NetworkDataFetcher {
    let networkService = NetworkService()
    
    func fetchTracks(urlString: String, response: @escaping(SearchResponse?) -> Void) {
        networkService.request(urlString: urlString) { (result) in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(SearchResponse.self, from: data)
                    response(tracks)
                } catch  let jsonError{
                    print("error code", jsonError)
                }
            case .failure(let error):
                print("Error\(error.localizedDescription)")
                response(nil)
            }
        }
    }
  
}


