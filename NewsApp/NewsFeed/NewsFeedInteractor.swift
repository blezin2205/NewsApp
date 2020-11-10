//
//  NewsFeedInteractor.swift
//  NewsApp
//
//  Created by Blezin on 24.10.2020.
//  Copyright (c) 2020 Blezin'sDev. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    private var feedResponse: FeedResponse?
    private var revealPostIds = [Int]()
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    switch request {
    
    case .getNewsFeed:
        fetcher.getFeed { [weak self] (feedResponse) in
            self?.feedResponse = feedResponse
            self?.presentFeed()
           
            
        }
    case .revealPostIds(postId: let postId):
        revealPostIds.append(postId)
       
        presentFeed()
    }
    
  }
    
    private func presentFeed() {
        guard let feedREsponse = feedResponse else {return}
               presenter?.presentData(response: .presentNewsFeed(feed: feedREsponse, revealPostIds: revealPostIds))
    }
  
}
