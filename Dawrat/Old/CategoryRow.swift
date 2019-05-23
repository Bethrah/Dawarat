//
//  CategoryRow.swift
//  ld
//
//  Created by بدور on 15/01/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import UIKit

class CategoryRow : UITableViewCell {
    
    var imgArr = [#imageLiteral(resourceName: "images (2)"),#imageLiteral(resourceName: "weddings-u53k312m8ybxecd70r2_ct677x380"),#imageLiteral(resourceName: "english-learning-apps-free-android")]
    var titels = ["MOST VIEWD","MOST LIKES","DISCOVER THIS"]
    var titels2 = ["C# beginner","wedding design","learn english"]
    
   
}

extension CategoryRow : UICollectionViewDataSource {
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! LargeCollectionCell
        cell.imageview.image = imgArr[indexPath.row]
        cell.MainLabel.text = titels[indexPath.row]
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

extension CategoryRow : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 20
        let itemWidth = collectionView.bounds.width - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
