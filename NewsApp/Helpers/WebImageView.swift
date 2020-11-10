//
//  WebImageView.swift
//  NewsApp
//
//  Created by Blezin on 24.10.2020.
//  Copyright © 2020 Blezin'sDev. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    func set(imageUrl: String?) {
        
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else {
            self.image = nil
            return}
        
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
        
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        
        guard let responseUrl = response.url else {return}
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
    }
    
    
}
