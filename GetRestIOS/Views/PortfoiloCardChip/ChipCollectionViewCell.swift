//
//  ChipCollectionViewCell.swift
//  GetRestIOS
//
//  Created by 최리안 on 06/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//
import UIKit

class ChipCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var roundChip: UIView!
    @IBOutlet var chipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let chipLabel = chipLabel {
//            roundChip.frame.size.width = CGFloat(chipLabel.frame.size.width + 20)
            roundChip.layer.cornerRadius = roundChip.frame.size.height / 2
            roundChip.setBorder(borderColor: .white, borderWidth: 0.5)
            chipLabel.textColor = .white
        }
    }
}
