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
    //    var label: String = ""
    var tqtq: String {
        get {
            print("\n\n\n카테고리 텍스트 ------->", categoryLabel!.text!)
            return categoryLabel.text!
        }
    }
    var a: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(AddPortfolioViewController.goCategory(sender:)))
        self.cateBtnClick.addGestureRecognizer(gesture)
        //        categoryLabel.text = "카테고리??"
        NotificationCenter.default.addObserver(forName: .CategoryData, object: nil, queue: OperationQueue.main) { (notification) in
            let cate = notification.object as! CategoryVC
            self.categoryLabel.text = cate.ll
            self.a = cate.selectCate
        }
        NotificationCenter.default.addObserver(forName: .PortfolioDate, object: nil, queue: OperationQueue.main) { (notification) in
            let dateVc = notification.object as! DatepickerStartEndVC
            self.dateLabel.text = dateVc.formmatedDate
        }
    }
    
    @objc func goCategory(sender:UIGestureRecognizer) {
        
        let storyboard  = UIStoryboard(name: "Portfolio", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CategoryVC")
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        
//        let storyboard_  = UIStoryboard(name: "Portfolio", bundle: nil)
//        let dvc = storyboard_.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
//        print("라벨벨냐ㅐ얾;ㅣㄴ러인;십ㄹ", categoryLabel.text)
//        dvc.CategoryLabel = categoryLabel.text!
//        print("dvc",dvc.CategoryLabel)
        
        NotificationCenter.default.post(name: .Categorytqtq, object: self)
        
        self.present(vc, animated: true)
        
    }
    
    
    
    
    
}
