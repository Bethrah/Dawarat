//
//  CollectionCell.swift
//  Dawrat
//
//  Created by بدور on 08/05/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import Foundation
import UIKit
class CollectionCellIn: UICollectionViewCell {
    
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var title2Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 8
        iconView.layer.borderColor =  UIColor.gray.cgColor
        iconView.layer.borderWidth = 1
       iconView.contentMode = .scaleToFill
        
    }
    
}
