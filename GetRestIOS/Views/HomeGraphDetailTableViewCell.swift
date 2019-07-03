//
//  HomeGraphTableView.swift
//  GetRestIOS
//
//  Created by 박경선 on 02/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class HomeGraphDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var portfolioTitle: UILabel!
    @IBOutlet weak var portfolioDuration: UILabel!
    @IBOutlet weak var hashTagsCollectionView: UICollectionView!
    var portfolioHashTags: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nibName = UINib(nibName: "HashTagCollectionViewCell", bundle: nil)
        
        self.hashTagsCollectionView.delegate = self
        self.hashTagsCollectionView.dataSource = self
        self.hashTagsCollectionView.register(nibName, forCellWithReuseIdentifier: "hashTagCell")
        
        // 다이나믹한 셀 크기
        let hashTagsCVFlowLayout = hashTagsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        hashTagsCVFlowLayout.estimatedItemSize = CGSize(width: 64, height: 27)
    }
    
    func addWhitespace(tag: String) -> String {
        return tag + "        "
    }
    
    @IBAction func goPortfolioPageAction(_ sender: UIButton) {
//        sender.tintColor = UIColor.white
        portfolioTitle.textColor = UIColor.white
        portfolioDuration.textColor = UIColor.white
        hashTagsCollectionView.backgroundColor = UIColor.mainColorBlue
    }
}

extension HomeGraphDetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return portfolioHashTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hashTagCell", for: indexPath) as! HashTagCollectionViewCell
        let tagString = addWhitespace( tag: portfolioHashTags[indexPath.row])
        cell.hashTagLabel?.text = tagString
        return cell
    }
    
}
