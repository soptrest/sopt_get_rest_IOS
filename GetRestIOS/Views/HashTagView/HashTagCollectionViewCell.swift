//
//  HashTagCollectionViewCell.swift
//  GetRestIOS
//
//  Created by 박경선 on 03/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class HashTagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var hashTagView: UIView!
    @IBOutlet weak var hashTagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let hashTagLabel = hashTagLabel {
            hashTagLabel.layer.cornerRadius = hashTagLabel.frame.size.height/2
            hashTagLabel.layer.borderColor = UIColor.mainColorBlue.cgColor
            hashTagLabel.layer.borderWidth = 0.5
        }
    }
}
