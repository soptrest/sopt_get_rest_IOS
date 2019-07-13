//
//  PortfolioTableViewCell.swift
//  GetRestIOS
//
//  Created by 최리안 on 06/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet var portfolioImg: UIImageView!
    @IBOutlet var portfolioTitle: UILabel!
    @IBOutlet var portfolioDate: UILabel!
    @IBOutlet var chipCollection: UICollectionView!
    @IBOutlet var dim: UIView!
    @IBOutlet var dim_: UIView!
    
    var tagList: [String] = []
    var t2: [String] = ["1", "안녇", "ㅓㅗ혀"]
    var t1: [String] = ["1", "안녇"]
    var t3: [String] = ["ux디자인"]
    var wid = 0
//    var img : UIImageView = UIImage(named: "icImg")
    
    override func awakeFromNib() {

        super.awakeFromNib()
        
        chipCollection.delegate = self
        chipCollection.dataSource = self
        let nibName = UINib(nibName: "ChipCollectionViewCell", bundle: nil)
        chipCollection.register(nibName, forCellWithReuseIdentifier: "Chip")
        // Initialization code
        portfolioImg.layer.cornerRadius = 5
        dim.layer.cornerRadius = 5
        dim_.layer.cornerRadius = 5
//        dim.addSubview(img)
        
        selectionStyle = .none
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chipCollection.dequeueReusableCell(withReuseIdentifier: "Chip", for: indexPath) as! ChipCollectionViewCell
        cell.chipLabel.text = self.tagList[indexPath.row]
//        print(cell.chipLabel.text!.count*10)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        wid += 10*(tagList.count-1)
        let leftInset = (375 - CGFloat(wid)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == chipCollection {
//            let cell = chipCollection.dequeueReusableCell(withReuseIdentifier: "Chip", for: indexPath) as! ChipCollectionViewCell
            wid += (tagList[indexPath.row].count*10+20)
            return CGSize(width: tagList[indexPath.row].count*10+20 , height: 40)
            
        }  else {
            return CGSize(width: 30, height: 30)
        }
    }
    
}
//layoutFCV.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//let filterCV = UICollectionView(frame: self.view.bounds, collectionViewLayout: layoutFCV)
//--



