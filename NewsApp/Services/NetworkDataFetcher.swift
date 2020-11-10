//
//  NetworkDataFetcher.swift
//  NewsApp
//
//  Created by Blezin on 23.10.2020.
//  Copyright © 2020 Blezin'sDev. All rights reserved.
//

import Foundation

protocol DataFetcher {
    
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post, photo"]
        networking.request(path: API.newFeed, params: params) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                response(nil)
            }
            
            let decoder = self.decodeJSON(type: FeedResponseWrapp.self, from: data)
            response(decoder?.response)
            
        }
    }
      
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else {return nil}
        return response
        
    }
    
    
}
