//
//  NewsFeedModels.swift
//  NewsApp
//
//  Created by Blezin on 24.10.2020.
//  Copyright (c) 2020 Blezin'sDev. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        
        case getNewsFeed
        case revealPostIds(postId: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: FeedResponse, revealPostIds: [Int])
      }
    }
    struct ViewModel {
      enum ViewModelData {

        case displayNewsFeed(feedViewModel: FeedViewModel)
      }
    }
  }
  
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        
        

        var postId: Int
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String
        var comments: String
        var shares: String
        var views: String
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
        var sizes: FeedCellSizes

    }
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    
    let cells: [Cell] 
    
}
