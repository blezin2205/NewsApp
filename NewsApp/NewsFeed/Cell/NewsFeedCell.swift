//
//  NewsFeedCell.swift
//  NewsApp
//
//  Created by Blezin on 24.10.2020.
//  Copyright © 2020 Blezin'sDev. All rights reserved.
//

import Foundation
import UIKit

protocol NewFeedCellDelegate: class {
    func revealPost(for cell: NewsFeedCell)
}

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String { get }
    var comments: String { get }
    var shares: String { get }
    var views: String { get }
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] {get}
    var sizes: FeedCellSizes {get}
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? {get}
    var width: Int {get}
    var height: Int {get}
    
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
    var moreTextButtonFrame: CGRect { get }
}

class NewsFeedCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCell"
    weak var delegate: NewFeedCellDelegate?
    
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var lieksLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var sharedLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью", for: .normal)
        return button
    }()
    
    let galleryCollectionView = GalleryCollectionView()
     
    override func prepareForReuse() {
        iconImageView.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        backgroundColor = .clear
        selectionStyle = .none
        cardView.addSubview(moreTextButton)
        cardView.addSubview(galleryCollectionView)
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside)
        
    }
    
    @objc func moreTextButtonTouch() {
        
        delegate?.revealPost(for: self)
        
    }
    
    func set(viewModel: FeedCellViewModel) {
        
        iconImageView.set(imageUrl: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        lieksLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharedLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        postLabel.frame = viewModel.sizes.postLabelFrame
        
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
     
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageUrl: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
            
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachments)
        }
        else {
                   postImageView.isHidden = true
            galleryCollectionView.isHidden = true
               }
        

        
    }
    
    
}
