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
        
//        selectTV.frame.size.height = CGFloat((118+20)*data.count)
        selectTV.delegate = self
        selectTV.dataSource = self
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = selectTV.dequeueReusableCell(withIdentifier: "SelectCell") as! SelectCell
        
        if indexPath.row == data.count  {
            print("외부?")
            
            cell.pfImg.backgroundColor = .lightGray
            cell.pfImg.roundCorners(corners: .allCorners, radius: 5)
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
    
    private func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        let storyboard  = UIStoryboard(name: "Recruit", bundle: nil)
        
        // 아/Users/leean/GetRestIOS/GetRestIOS/Controllers/Recruit/Selelct/QuestionCell.swift까 입력했던 storyboard id -> writeview_yw를 입력해주자ㅏ.
        let vc = storyboard.instantiateViewController(withIdentifier: "PortfolioSelectVC") as! PortfolioSelectVC
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)

    }

}
