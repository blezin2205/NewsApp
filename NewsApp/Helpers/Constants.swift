//
//  Constants.swift
//  NewsApp
//
//  Created by Blezin on 02.11.2020.
//  Copyright © 2020 Blezin'sDev. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
  static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
  static let topViewHeight: CGFloat = 39
  static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight , left: 8, bottom: 8, right: 8)
  static let postLabelFont = UIFont.systemFont(ofSize: 15)
  static let bottomViewHeight: CGFloat = 51
  
  static let minifiedPostLimitLines: CGFloat = 8
  static let minifiedPostLines: CGFloat  = 6
  
  static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
  static let moreTextButtonSize = CGSize(width: 170, height: 30)
  
  
  static let bottomViewViewHeight: CGFloat = 44
  static let bottomViewViewWidth: CGFloat = 80
  static let bottomViewViewsIconSize: CGFloat = 24

}
