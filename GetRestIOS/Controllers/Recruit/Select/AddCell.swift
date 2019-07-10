//
//  AddCell.swift
//  GetRestIOS
//
//  Created by 최리안 on 10/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class AddCell: UITableViewCell {

    @IBOutlet var addBtnVIew: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addBtnVIew.roundCorners(corners: .allCorners, radius: 5)
        addBtnVIew.setBorder(borderColor: .black, borderWidth: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
