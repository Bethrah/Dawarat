//
//  newCol.swift
//  ld
//
//  Created by بدور on 15/01/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//


import UIKit

class newCol: UITableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        return cell
    }
    
    var categories = ["Action", "Drama", "Science Fiction", "Kids", "Horror"]
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   
    
}
