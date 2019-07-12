//
//  CategoryCell.swift
//  GetRestIOS
//
//  Created by 최리안 on 12/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet var cellBackground: UIView!
    @IBOutlet var cateLabel: UILabel!
    @IBOutlet var bottomLine: UIView!
    var isChceked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomLine.backgroundColor = .bottomGray
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
