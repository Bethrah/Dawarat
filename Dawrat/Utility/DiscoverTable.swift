//
//  DiscoverTable.swift
//  Dawrat
//
//  Created by بدور on 07/02/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import Foundation
import UIKit

class DiscoverTable : UIViewController  ,  CellTapped {
    func cellGotTapped(indexOfCell: Int) {
        print("Tapped cell is \(indexOfCell)")
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
    
    
    var Table : [Row] = []
    
   
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
          //// set tha data (Remove)
        // this style will fill autumaticlly  inside cell class
var row1 = Row(num: "0", style: "Most_Style", data : ["RowTitle":"","ItemsNumber":"3","ItemsIDs":""])
var row2 = Row(num: "1", style: "SmallImeg_Style", data : ["RowTitle":"Best English Courses","ItemsNumber":"3","ItemsIDs":"[1a1 ,13b,3sb5]"])
    var row3 = Row(num: "2", style: "TableInCell_Style", data : ["RowTitle":"Best Offer","ItemsNumber":"6","ItemsIDs":"[1a1 ,13b,3sb5,1afd ,dgfbg,3sb35rg5]"])
        Table.append(row1)
        Table.append(row2)
        Table.append(row3)
   print(Table.count)
        ///////
        let nib = UINib.init(nibName: "MostStyleRow", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "MostStyleRow")
        let nib2 = UINib.init(nibName: "SmallImegStyle", bundle: nil)
        self.tableView.register(nib2, forCellReuseIdentifier: "SmallImegStyle")
        let nib3 = UINib.init(nibName: "TableInCellStyleRow", bundle: nil)
        self.tableView.register(nib3, forCellReuseIdentifier: "TableInCellStyleRow")
        // Set automatic dimensions for row height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
}
extension DiscoverTable : UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        

       let rowStyle = Table[indexPath.row].Style
         print(rowStyle)
        switch rowStyle {
        case "Most_Style" :
          if  let cell = tableView.dequeueReusableCell(withIdentifier: "MostStyleRow",for: indexPath) as? MostStyleRow //CatogeryRow
            {
                let nib = UINib.init(nibName: "LargeCollectionCell", bundle: nil)
                cell.collectionView.register(nib, forCellWithReuseIdentifier: "LargeCollectionCell")
                cell.delegate = self  //Assign delegate to self
                
                print(cell.titels[0])
                return cell
            }
          else {print("no cell") }
        case "SmallImeg_Style" :
          if  let cell = tableView.dequeueReusableCell(withIdentifier: "SmallImegStyle",for: indexPath) as? SmallImegStyleRow //lernenglishrow
          {
            let nib = UINib.init(nibName: "SmallCollectionCell", bundle: nil)
            cell.collectionView.register(nib, forCellWithReuseIdentifier: "SmallCollectionCell")
            cell.data = Table[indexPath.row].Data
            return cell
            
            }
            else {print("no cell") }
        case "TableInCell_Style":
          if  let cell = tableView.dequeueReusableCell(withIdentifier: "TableInCellStyleRow",for: indexPath) as? TableInCellStyleRow //freecourses
          {   cell.data = Table[indexPath.row].Data
            let nib = UINib.init(nibName: "CollectionCellIn", bundle: nil)
            cell.collection.register(nib, forCellWithReuseIdentifier: "CollectionCellIn")
             cell.delegate = self  //Assign delegate to self
            return cell
            }
     else {print("no cell") }
        default: break
            
        }
        
        // return the default cell if none of above succeed
        return UITableViewCell()
    }
    
//    // UITableViewAutomaticDimension calculates height of label contents/text
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row==0){
            return 321
      }
       else if(indexPath.row==1){
          return 325
      }
        else if(indexPath.row==2){
            return 500
        }
      else{
           return 300; //a default size if the cell index path is anything other than the 1st or second row.
        }
    }
}
