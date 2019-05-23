//
//  MostStyleRow.swift
//  Dawrat
//
//  Created by بدور on 08/02/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import Foundation
import UIKit
class MostStyleRow : UITableViewCell
{
   
    @IBOutlet weak var collectionView: UICollectionView!
     private var indexOfCellBeforeDragging = 0
    @IBOutlet weak var collectinViewLayout: UICollectionViewFlowLayout!
    var delegate : CellTapped!

    var imgArr = [#imageLiteral(resourceName: "Machine-Learning-with-Python"),#imageLiteral(resourceName: "photoshopschool8_resize_md"),#imageLiteral(resourceName: "digital")]
    var titels = ["MOST VIEWD","MOST LIKES","DISCOVER THIS"]
    var titels2 = ["Complete Python Bootcamp","Photoshop CC 2019 MasterClass","The Complete Digital Marketing Course"]
 
    override func didMoveToWindow() {
        collectinViewLayout.minimumLineSpacing = 0
        configureCollectionViewLayoutItemSize()

    }
    private func calculateSectionInset() -> CGFloat {
        let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
        let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
        let cellBodyWidth: CGFloat = 320 + (cellBodyViewIsExpended ? 174 : 0)
        
        
        let inset = (collectinViewLayout.collectionView!.frame.width - cellBodyWidth) / 4
        return inset
    }
    
    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = calculateSectionInset() // This inset calculation is some magic so the next and the previous cells will peek from the sides. Don't worry about it
        collectinViewLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        collectinViewLayout.itemSize = CGSize(width: collectinViewLayout.collectionView!.frame.size.width - inset * 2, height: collectinViewLayout.collectionView!.frame.size.height)
    }
    
    private func indexOfMajorCell() -> Int {
        let itemWidth = collectinViewLayout.itemSize.width
        let proportionalOffset = collectinViewLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(titels.count - 1, index))
        return safeIndex
    }
    
}

extension MostStyleRow : UICollectionViewDataSource , UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeCollectionCell", for: indexPath) as! LargeCollectionCell
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(delegate != nil) {
            self.delegate.cellGotTapped(indexOfCell: indexPath.item)
        }
    }
 
    // =================================
    // MARK: - UICollectionViewDelegate:
    // =================================
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset
        
        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()
        
        // calculate conditions:
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < titels.count && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        if didUseSwipeToSkipCell {
            
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectinViewLayout.itemSize.width * CGFloat(snapToIndex)
            
            // Damping equal 1 => no oscillations => decay animation:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            // This is a much better way to scroll to a cell:
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectinViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension MostStyleRow : UICollectionViewDelegateFlowLayout {
    
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemsPerRow:CGFloat = 4
//        let hardCodedPadding:CGFloat = 20
//        let itemWidth = collectionView.bounds.width - hardCodedPadding
//        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
//        return CGSize(width: itemWidth, height: itemHeight)
//
//    }
}

protocol CellTapped: class {
    /// Method
    func cellGotTapped(indexOfCell: Int)
}

