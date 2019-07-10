//
//  MyResumeTableViewCell.swift
//  GetRestIOS
//
//  Created by 박경선 on 10/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class MyResumeTableViewCell: UITableViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var jobType: UILabel!
    @IBOutlet weak var rightButton: UIView!
    var isDeleteMode: Bool = false
    var expireCheck: Bool?
    
    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        cardView.roundCorners(corners: [.allCorners], radius: 4)
        selectionStyle = .none
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isDeleteMode {
            if selected {
                rightButton.backgroundColor = UIColor(patternImage: UIImage(named: "btnResumeMultiActive")!)
            } else {
                rightButton.backgroundColor = UIColor(patternImage: UIImage(named: "btnResumeMulti")!)
            }
        } else {
            rightButton.backgroundColor = UIColor(patternImage: UIImage(named: "btnResumeNextstep")!)
        }
    }
    
}
