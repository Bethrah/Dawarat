//
//  Row.swift
//  Dawrat
//
//  Created by بدور on 08/02/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import Foundation
import UIKit
class Row {
    
     var Number = "0"
    
    var Style = ""     // "Most_Style","TableInCell_Style","SmallImeg_Style"""
    
    var Data = [String: String]()   // key = "RowTitle", "ItemsNumber" , "ItemsIDs"
    
    init(num : String , style : String , data : [String: String] ) {
        Number = num
        Style = style
        Data = data
     }
    
}
