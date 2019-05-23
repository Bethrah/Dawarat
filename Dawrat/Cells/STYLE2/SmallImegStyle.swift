//
//  SmallImegStyle.swift
//  Dawrat
//
//  Created by بدور on 08/02/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import Foundation
import UIKit
class SmallImegStyleRow : UITableViewCell {
    var data = [String: String]()   // key = "RowTitle", "ItemsNumber" , "ItemsIDs"
    @IBOutlet weak var collectionView: UICollectionView!

    var imgArr = [#imageLiteral(resourceName: "download (2)"),#imageLiteral(resourceName: "wse-logo"),#imageLiteral(resourceName: "EkN9hFor"),#imageLiteral(resourceName: "NOUMvafm")]
    // var titels = ["FREE COURSE","MOST VIEWD","MOST LIKES"]
    var titels2 = ["2000 SR","1500 SR","2300 SR","2700 SR"]
    
    
    }
    
extension SmallImegStyleRow : UICollectionViewDataSource {
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallCollectionCell", for: indexPath) as! SmallCollectionCell
            cell.imageview.image = imgArr[indexPath.row]
            // cell.title1label.text = titels[indexPath.row]
            cell.MainLabel.text = titels2[indexPath.row]
            cell.imageview.layer.cornerRadius = 8.0
            cell.imageview.clipsToBounds = true
            cell.imageview.layer.borderColor =  UIColor.gray.cgColor
            cell.imageview.layer.borderWidth = 1
            cell.imageview.contentMode = .scaleToFill
             print("11")
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imgArr.count
        }
        
        
        
    }
    
    extension SmallImegStyleRow : UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemsPerRow:CGFloat = 2.8
            let hardCodedPadding:CGFloat = 5
            let itemWidth = collectionView.bounds.width/itemsPerRow - hardCodedPadding
            let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
            return CGSize(width: itemWidth, height: itemHeight)
        }
        
    }

