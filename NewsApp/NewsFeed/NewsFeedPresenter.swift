//
//  NewsFeedPresenter.swift
//  NewsApp
//
//  Created by Blezin on 24.10.2020.
//  Copyright (c) 2020 Blezin'sDev. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
  weak var viewController: NewsFeedDisplayLogic?
    var cellLayoutCalculate: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:MM"
        return dt
    }()
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
  
    switch response {
 
    case .presentNewsFeed(feed: let feed, let revealPostIds):
        
        let cells = feed.items.map { (feedItem) in
            cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealPostIds: revealPostIds)
        }
        
        
        
        
        let feedViewModel = FeedViewModel.init(cells: cells)
        viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
    }
  }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealPostIds: [Int]) -> FeedViewModel.Cell {
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSized = revealPostIds.contains { (postId) -> Bool in
            return postId == feedItem.postId
        }
        
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        let sizes = cellLayoutCalculate.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
        
        return FeedViewModel.Cell.init(postId: feedItem.postId, iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       photoAttachments: photoAttachments,
                                        sizes: sizes)
        
    }
    
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourseId = sourceId  >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourseId
            
           
        }
         return profileRepresentable!
    }
    
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else {return []}
        
        return attachments.compactMap { (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else {return nil}
            return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.srcBIG, width: photo.width, height: photo.height)
        }
        
    }
    
  
}
