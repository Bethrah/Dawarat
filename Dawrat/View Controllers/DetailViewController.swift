//
//  DetailViewController.swift
//  Dawrat
//
//  Created by بدور on 15/05/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import Foundation
import UIKit
class DetailViewController : UIViewController {
  
    @IBOutlet weak var EnrollBtn : UIButton!
     @IBOutlet weak var EnrollView : UIView!

    override func viewDidLoad() {
        
    }
    

    @IBAction func Enroll(_ sender: Any) {
      //  let EnrollBtn: UIButton = sender as! UIButton
      
        EnrollBtn.setTitle("Done", for: .normal)
        EnrollBtn.isEnabled = false
        EnrollView.isHidden = false
  }
    @IBAction func Dismiss(_ sender: Any) {
       
        EnrollView.isHidden = true
    }
  
}
