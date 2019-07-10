//
//  HomeGraphTableView.swift
//  GetRestIOS
//
//  Created by 박경선 on 02/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class HomeGraphDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var portfolioTitle: UILabel!
    @IBOutlet weak var portfolioDuration: UILabel!
    @IBOutlet weak var isSelectBtn: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    func addWhitespace(tag: String) -> String {
        return tag + "        "
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            cardView.backgroundColor = UIColor.mainGreen
            isSelectBtn.backgroundColor = UIColor(patternImage: UIImage(named: "icPortfolioButton")!)
            portfolioTitle.textColor = UIColor.white
            portfolioDuration.textColor = UIColor.white
            
        } else {
            cardView.backgroundColor = UIColor(red: 226.0/255.0, green: 239.0/255.0, blue: 219.0/255.0, alpha: 1.0)
            isSelectBtn.backgroundColor = UIColor(patternImage: UIImage(named: "icGoPortfolioButton")!)
            portfolioTitle.textColor = UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)
            portfolioDuration.textColor = UIColor(red: 56.0/255.0, green: 56.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        }
        
    }
}
