//
//  SelectCell.swift
//  GetRestIOS
//
//  Created by 최리안 on 10/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class SelectCell: UITableViewCell {

    @IBOutlet var pfImg: UIImageView!
    @IBOutlet var pfTitle: UILabel!
    @IBOutlet var pfDate: UILabel!
    @IBOutlet var addBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pfImg.roundCorners(corners: .allCorners, radius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
