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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func addWhitespace(tag: String) -> String {
        return tag + "        "
    }
    
    @IBAction func goPortfolioPageAction(_ sender: UIButton) {
        sender.tintColor = UIColor.white
        portfolioTitle.textColor = UIColor.white
        portfolioDuration.textColor = UIColor.white
    }
}
