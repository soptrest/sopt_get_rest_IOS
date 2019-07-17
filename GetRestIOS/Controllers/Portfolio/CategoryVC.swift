//
//  CategoryVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 12/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var backBtnView: UIView!
    @IBOutlet var cateTV: UITableView!
    var cate: [String] = ["대외활동", "학교활동", "공모전", "경력사항", "기타"]
    var selectCate: Int = 10
    var selectCateIndex: IndexPath = []
    var ll: String {
        get {
            if selectCate == 10 {
                return "카테고리"
            } else {
                return cate[selectCate]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cateTV.delegate = self
        cateTV.dataSource = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(CategoryVC.goBack(sender:)))
        self.backBtnView.addGestureRecognizer(gesture)
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(false)
//
//    }
//
    @objc func goBack(sender:UIGestureRecognizer) {
        NotificationCenter.default.post(name: .CategoryData, object: self)
        dismiss(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cate.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        cell.cateLabel.text = cate[indexPath.row]
        
        
        
        if selectCate != 10 {
            print("selectCate-> ", selectCate, "indexPath.row ->", indexPath.row)
            if  selectCate == indexPath.row {
                cell.isChceked = true
                cell.cateLabel.textColor = .white
                cell.backgroundColor = .barMainGreen
                selectCateIndex = indexPath
            }
        } else {
            print("아무것도 선택하지 않은 상태")
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CategoryCell
        
        if cell.isChceked {
            print("off")
            cell.cateLabel.textColor = .btnBarItemTitleColor
            cell.backgroundColor = .white
            cell.isChceked = false
            selectCate = 10
            
        }
        else {
            if (selectCate != indexPath.row) && (selectCate != 10) {
                let cell_ = tableView.cellForRow(at: selectCateIndex) as! CategoryCell
                cell_.cateLabel.textColor = .btnBarItemTitleColor
                cell_.backgroundColor = .white
                cell_.isChceked = false
                
                cell.isChceked = true
                cell.cateLabel.textColor = .white
                cell.backgroundColor = .barMainGreen
            } else  {
                cell.isChceked = true
                cell.cateLabel.textColor = .white
                cell.backgroundColor = .barMainGreen
            }
            print("on")
            selectCateIndex = indexPath
            selectCate = indexPath.row
            cell.isChceked = true
        }
    }
    
}
