//
//  SearchViewController.swift
//  Dawrat
//
//  Created by بدور on 16/05/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import Foundation
import UIKit
class SearchViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var Courses = [["Beginner to Pro in Excel","Computer","Jeddah"],["Management Skills","Mangement","Riyadh"],["Life Coaching Certification","ForTrainer","khober"],["Color Grading Masterclass","Photophraphy","Jeddah"],["Ultimate Google Ads","Markting","Jeddah"],["The Complete Digital Marketing Course ","Markting","Riyadh"]]
   
    var searching = false
    var searchedCourses = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self as? UISearchBarDelegate
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedCourses.count
        } else {
            return Courses.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? tableCell
      {  if searching {
            //cell?.textLabel?.text = searchedCourses[indexPath.row]
            cell.titel.text = searchedCourses[indexPath.row][0]
            cell.category.text = searchedCourses[indexPath.row][1]
            cell.location.text = searchedCourses[indexPath.row][2]

        } else {
            cell.titel.text = Courses[indexPath.row][0]
            cell.category.text = Courses[indexPath.row][1]
            cell.location.text = Courses[indexPath.row][2]
           // cell?.textLabel?.text = countryNameArr[indexPath.row]
        }
        return cell }
        // return the default cell if none of above succeed
        else { return UITableViewCell()}
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    
}

extension SearchViewController : UISearchBarDelegate {
    
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      
      searchedCourses.removeAll()
        if !(searchText.isEmpty){
        for i in 0...Courses.count-1 {
            for j in 0...2 {
                if (Courses[i][j].lowercased().contains(searchText.lowercased()))
               {
                searchedCourses.append(Courses[i])
                  }
                
            }
            }
        
        searching = true
            tableView.reloadData()}
    
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        
        tableView.reloadData()
    }
   
}
class tableCell : UITableViewCell
{
    
    @IBOutlet weak var titel: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var location: UILabel!

}
