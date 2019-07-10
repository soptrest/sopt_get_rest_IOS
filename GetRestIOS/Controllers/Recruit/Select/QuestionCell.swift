//
//  QuestionCell.swift
//  GetRestIOS
//
//  Created by 최리안 on 10/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var askNum: UILabel!
    @IBOutlet var askLabel: UILabel!
    @IBOutlet var selectTV: UITableView!
    var img: UIImage? = UIImage(named: "icImg")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectTV.delegate = self
        selectTV.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellA = self.selectTV.dequeueReusableCell(withIdentifier: "AddCell") as! AddCell
//        let cellS = self.selectTV.dequeueReusableCell(withIdentifier: "SelectCell") as! SelectCell
        
//        cellA.askLabel.text = q[indexPath.row]
//        cell.askNum.text = "문항\(indexPath.row+1)"
//        cell.askNum.sizeToFit()
        //        cell.askLabel.sizeToFit()
        print("selected")
        return cellA
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("넘 count")
        return 1
    }

}
