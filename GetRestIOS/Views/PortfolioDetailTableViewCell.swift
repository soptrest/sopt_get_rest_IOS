////
////  PortfolioDetailTableViewCell.swift
////  Alamofire
////
////  Created by 박경선 on 04/07/2019.
////
//
//import UIKit
//
//class PortfolioDetailTableViewaCell: UITableViewCell {
//
//    @IBOutlet weak var categoryLabel: UILabel!
//    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var durationLabel: UILabel!
//    @IBOutlet weak var hashTagsCollectionView: UICollectionView!
//    @IBOutlet weak var contentLabel: UILabel!
//    var portfolioHashTags: [String] = []
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        let nibName = UINib(nibName: "HashTagCollectionViewCell", bundle: nil)
//        self.hashTagsCollectionView.delegate = self
//        self.hashTagsCollectionView.dataSource = self
//        self.hashTagsCollectionView.register(nibName, forCellWithReuseIdentifier: "hashTagCell")
//        let hashTagsCVFlowLayout = hashTagsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        hashTagsCVFlowLayout.estimatedItemSize = CGSize(width: 64, height: 27)
//        contentLabel.numberOfLines = 0
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
//}
//
//extension PortfolioDetailTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return portfolioHashTags.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hashTagCell", for: indexPath) as! HashTagCollectionViewCell
//        let tagString = (portfolioHashTags[indexPath.row]) + "        "
//        cell.hashTagLabel?.text = tagString
//        return cell
//    }
//}
