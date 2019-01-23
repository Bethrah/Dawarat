//
//  ViewController.swift
//  ld
//
//  Created by بدور on 07/01/2019.
//  Copyright © 2019 Bdour. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    
    var imgArr = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
       imgArr = [#imageLiteral(resourceName: "images (2)"),#imageLiteral(resourceName: "weddings-u53k312m8ybxecd70r2_ct677x380"),#imageLiteral(resourceName: "english-learning-apps-free-android")]
        var titels = ["FREE COURSE","MOST VIEWD","MOST LIKES"]
        var titels2 = ["C# beginner","wedding design","learn english"]
        
        
      
        for i in 0..<imgArr.count
        {
             let x = self.view.frame.size.width * CGFloat(i) + 20
            var y : CGFloat = 20.0

            let titleLabel = UILabel()
            titleLabel.text = titels[i]
            titleLabel.textColor = UIColor.blue
            titleLabel.textAlignment = .left
            titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
            titleLabel.frame = CGRect(x: x, y: y, width: scrollview.frame.width, height: 20)
           
           y+=titleLabel.frame.height
            let titleLabel2 = UILabel()
            titleLabel2.text = titels2[i]
            titleLabel2.font = titleLabel2.font.withSize(25)
            titleLabel2.textColor = UIColor.black
            titleLabel2.textAlignment = .left
            titleLabel2.frame = CGRect(x: x, y: y , width: scrollview.frame.width, height: 40)
        
            y+=titleLabel2.frame.height

            let imageView = UIImageView()
            imageView.frame = CGRect(x: x, y:y , width: self.view.frame.width-40, height: self.scrollview.frame.height-y)
            imageView.layer.cornerRadius = 8.0
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleToFill
            imageView.image = imgArr[i]
            
            scrollview.contentSize.width = self.view.frame.width * CGFloat(i + 1)
            scrollview.addSubview(titleLabel)
            scrollview.addSubview(titleLabel2)

            scrollview.addSubview(imageView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

