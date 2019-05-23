//
//  TableInCellStyleRow.swift
//  Dawrat
//
//  Created by بدور on 08/02/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import Foundation
import UIKit
class TableInCellStyleRow : UITableViewCell {
 
        var delegate : CellTapped!
    var data = [String: String]()   // key = "RowTitle", "ItemsNumber" , "ItemsIDs"
    @IBOutlet var columnStack: UIStackView!
    @IBOutlet var collection: UICollectionView!
    
    
    var imgArr = [#imageLiteral(resourceName: "images (2)"),#imageLiteral(resourceName: "weddings-u53k312m8ybxecd70r2_ct677x380"),#imageLiteral(resourceName: "english-learning-apps-free-android")]
    var titels = ["Beginner to Pro in Excel","Management Skills","Life Coaching Certification","Color Grading Masterclass","Ultimate Google Ads","The Complete Digital Marketing Course "]
    var titels2 = ["Computer","Mangement","ForTrainer","Photophraphy","Markting"]
}

extension TableInCellStyleRow : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellIn", for: indexPath) as! CollectionCellIn
        cell.titleLabel.text = titels[indexPath.row]
        let randomIndex = Int(arc4random_uniform(UInt32(titels2.count)))
        cell.title2Label.text = titels2[randomIndex]
        //cell.iconView.backgroundColor = UIColor(hue: CGFloat(indexPath.item) / 20.0, saturation: 0.8, brightness: 0.9, alpha: 1)
        let randomIndex2 = Int(arc4random_uniform(UInt32(imgArr.count)))
        cell.iconView.image = imgArr[randomIndex2]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(delegate != nil) {
            self.delegate.cellGotTapped(indexOfCell: indexPath.item)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize.width = min((collection?.bounds.size.width)! - 20, 400)
        NSLayoutConstraint.activate([
            collection.widthAnchor.constraint(equalTo: columnStack.widthAnchor),
            collection.heightAnchor.constraint(equalToConstant: layout.itemSize.height * 3)
            
            ])
        
        let bounds = scrollView.bounds
        let xTarget = targetContentOffset.pointee.x
        
        // This is the max contentOffset.x to allow. With this as contentOffset.x, the right edge of the last column of cells is at the right edge of the collection view's frame.
        let xMax = scrollView.contentSize.width - scrollView.bounds.width
        
        if abs(velocity.x) <= snapToMostVisibleColumnVelocityThreshold {
            let xCenter = scrollView.bounds.midX
            let poses = layout.layoutAttributesForElements(in: bounds) ?? []
            // Find the column whose center is closest to the collection view's visible rect's center.
            let x = poses.min(by: { abs($0.center.x - xCenter) < abs($1.center.x - xCenter) })?.frame.origin.x ?? 0
            targetContentOffset.pointee.x = x
        } else if velocity.x > 0 {
            let poses = layout.layoutAttributesForElements(in: CGRect(x: xTarget, y: 0, width: bounds.size.width, height: bounds.size.height)) ?? []
            // Find the leftmost column beyond the current position.
            let xCurrent = scrollView.contentOffset.x
            let x = poses.filter({ $0.frame.origin.x > xCurrent}).min(by: { $0.center.x < $1.center.x })?.frame.origin.x ?? xMax
            targetContentOffset.pointee.x = min(x, xMax)
        } else {
            let poses = layout.layoutAttributesForElements(in: CGRect(x: xTarget - bounds.size.width, y: 0, width: bounds.size.width, height: bounds.size.height)) ?? []
            // Find the rightmost column.
            let x = poses.max(by: { $0.center.x < $1.center.x })?.frame.origin.x ?? 0
            targetContentOffset.pointee.x = max(x, 0)
        }
    }
    
    // Velocity is measured in points per millisecond.
    private var snapToMostVisibleColumnVelocityThreshold: CGFloat { return 0.3 }
    
}


