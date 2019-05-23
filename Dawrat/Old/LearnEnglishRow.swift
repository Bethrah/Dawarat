//
//  LearnEnglish.swift
//  ld
//
//  Created by بدور on 16/01/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import Foundation
import UIKit

class LearnEnglishRow : UITableViewCell {
    
    var imgArr = [#imageLiteral(resourceName: "download (2)"),#imageLiteral(resourceName: "wse-logo"),#imageLiteral(resourceName: "EkN9hFor"),#imageLiteral(resourceName: "NOUMvafm")]
   // var titels = ["FREE COURSE","MOST VIEWD","MOST LIKES"]
    var titels2 = ["2000 SR","1500 SR","2300 SR","2700 SR"]
    
    
}

extension LearnEnglishRow : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! LargeCollectionCell
        cell.imageview.image = imgArr[indexPath.row]
       // cell.title1label.text = titels[indexPath.row]
        cell.ItemTitleLabel.text = titels2[indexPath.row]
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

extension LearnEnglishRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 2.8
        let hardCodedPadding:CGFloat = 5
        let itemWidth = collectionView.bounds.width/itemsPerRow - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
