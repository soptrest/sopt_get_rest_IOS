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
    var img: UIImage? = UIImage(named: "ex")
    
    var data = ["쉬자", "솝트", "쉬자"] as [Any]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectTV.frame.size.height = CGFloat((118+20)*data.count)
        selectTV.delegate = self
        selectTV.dataSource = self
        
        // Initialization code
    }
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style , reuseIdentifier: reuseIdentifier)
//        self.selectTV.delegate = self
//        self.selectTV.dataSource = self
//        self.selectTV.rowHeight = UITableView.automaticDimension
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        self.selectTV.delegate = self
//        self.selectTV.dataSource = self
//        self.selectTV.rowHeight = UITableView.automaticDimension
//    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print(data[indexPath.row])
//        print(indexPath.row)
//        print(data.count)
        
        let cell = selectTV.dequeueReusableCell(withIdentifier: "SelectCell") as! SelectCell
        
        if indexPath.row == data.count  {
            print("외부?")
            
            cell.pfImg.backgroundColor = .gray
            cell.pfImg.roundCorners(corners: .allCorners, radius: 5)
//            cell.pfImg.setBorder(borderColor: .black, borderWidth: 0.5)
//            cell.pfImg.clipsToBounds = true
//            cell.pfImg.layer.masksToBounds = true
            cell.addBtn.setImage(UIImage(named: "icAddPortfolio"), for: .normal)
            cell.pfDate.text = ""
            cell.pfTitle.text = ""
            return cell
        }
        
        cell.pfTitle.text = self.data[indexPath.row] as? String
        cell.pfImg.image = img
        cell.pfImg.contentMode = .scaleToFill
        cell.pfImg.clipsToBounds = true
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("넘 count")
        return (data.count+1)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 143
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

}
