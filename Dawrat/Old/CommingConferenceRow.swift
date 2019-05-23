//
//  CommingConferenceRow.swift
//  ld
//
//  Created by بدور on 21/01/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import Foundation
import UIKit

class CommingConferenceRow : UITableViewCell {
    
    var imgArr = [#imageLiteral(resourceName: "con2"),#imageLiteral(resourceName: "con1"),#imageLiteral(resourceName: "con3")]
 
    
    
}

extension CommingConferenceRow : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! LargeCollectionCell
        cell.imageview.image = imgArr[indexPath.row]
        cell.imageview.layer.cornerRadius = 8.0
        cell.imageview.clipsToBounds = true
        cell.imageview.layer.borderColor =  UIColor.gray.cgColor
        cell.imageview.layer.borderWidth = 1
        cell.imageview.contentMode = .scaleToFill
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    
    
}

extension CommingConferenceRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 1
        let hardCodedPadding:CGFloat = 50
        let itemWidth = collectionView.bounds.width - hardCodedPadding
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    
}
