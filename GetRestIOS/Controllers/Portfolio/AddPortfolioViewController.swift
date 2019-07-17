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
    @IBOutlet var dateLabel: UILabel!
    var a: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(AddPortfolioViewController.goCategory(sender:)))
        self.cateBtnClick.addGestureRecognizer(gesture)
        
        // 카테고리 값 가져옴
        NotificationCenter.default.addObserver(forName: .CategoryData, object: nil, queue: OperationQueue.main) { (notification) in
            let cate = notification.object as! CategoryVC
            self.categoryLabel.text = cate.ll
            self.a = cate.selectCate
            print("a", self.a)
        }
        // 데이트 값 가져옴
        NotificationCenter.default.addObserver(forName: .PortfolioDate, object: nil, queue: OperationQueue.main) { (notification) in
            let dateVc = notification.object as! DatepickerStartEndVC
            self.dateLabel.text = dateVc.formmatedDate
        }
    }
    
    @objc func goCategory(sender:UIGestureRecognizer) {
        
        let storyboard  = UIStoryboard(name: "Portfolio", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        vc.selectCate = self.a
        
        self.present(vc, animated: true)
        
    }
    
    
    
    
    
}
