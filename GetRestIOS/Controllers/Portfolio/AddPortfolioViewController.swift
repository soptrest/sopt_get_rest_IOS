//
//  AddPortfolioViewController.swift
//  GetRestIOS
//
//  Created by 최리안 on 06/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class AddPortfolioViewController: UIViewController {

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var cateBtnClick: UIView!
//    var label: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(AddPortfolioViewController.goCategory(sender:)))
        self.cateBtnClick.addGestureRecognizer(gesture)
//        categoryLabel.text = "카테고리??"
        NotificationCenter.default.addObserver(forName: .CategoryData, object: nil, queue: OperationQueue.main) { (notification) in
            let dateVc = notification.object as! CategoryVC
            self.categoryLabel.text = dateVc.CategoryLabel
        }
    }
    
    @objc func goCategory(sender:UIGestureRecognizer) {
        
        let storyboard  = UIStoryboard(name: "Portfolio", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CategoryVC")
//        let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        self.present(vc, animated: true)
    }
    

    
    

}
