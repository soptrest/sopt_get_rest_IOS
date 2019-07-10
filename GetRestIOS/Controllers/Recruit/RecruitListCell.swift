//
//  RecruitListCell.swift
//  GetRestIOS
//
//  Created by 최리안 on 08/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class RecruitListCell: UITableViewCell {
    @IBOutlet var recruitImg: UIImageView!
    @IBOutlet var recruitTitle: UILabel!
    @IBOutlet var recruitField: UILabel!
    @IBOutlet var recruitDate: UILabel!
    @IBOutlet var starBtn: UIButton!
    var isChecked = false
//    var checkedList: [Int] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    @IBAction func starOnOff(_ sender: UIButton) {
        isChecked = !isChecked
        if isChecked {
            starBtn.setImage(UIImage(named: "icStarOn"), for: .normal)
            
            
        } else {
            starBtn.setImage(UIImage(named: "icStarOff"), for: .normal)
        }
    }
    

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
