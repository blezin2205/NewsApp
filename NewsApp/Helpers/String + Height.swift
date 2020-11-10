//
//  String + Height.swift
//  NewsApp
//
//  Created by Blezin on 31.10.2020.
//  Copyright © 2020 Blezin'sDev. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil)
        
        return ceil(size.height)
        
    }
}
