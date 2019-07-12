//
//  SelectVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 10/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class SelectVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var askTV: UITableView!
    var num = ["문항", "문항", "문항"]
    var q = ["내가 생각하는 최고의 서비스디자인이란 무엇인가?", "다른 사람들과 함께 목표를 달성하기 위해 노력했던 경험은 무엇인지 서술하세요.", "내가 생각하는 최고의 서비스디자인이란 무엇인가?"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let cell = self.askTV.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionCell
//        askTV.rowHeight = UITableView.automaticDimension
//        askTV.estimatedRowHeight = CGFloat(cell.data.count)
        askTV.delegate = self
        askTV.dataSource = self
//        askTV.register(QuestionCell.self, forCellReuseIdentifier: "QuestionCell")
        print("뷰로드")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let index = askTV.indexPathForSelectedRow {
            askTV.deselectRow(at: index, animated: true)
        }
    }
    
    
    private func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        
    }
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.askTV.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionCell
//        cell.
        cell.askLabel.lineBreakMode = .byWordWrapping
        cell.askLabel.numberOfLines = 0
        cell.askLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.askLabel.preferredMaxLayoutWidth = 353
        
        cell.askLabel.text = q[indexPath.row]
        cell.askNum.text = "문항\(indexPath.row+1)"
        cell.askNum.sizeToFit()
        print("여기3")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("넘 카운트")
        return num.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("여기 한번오나?")
        let cell = self.askTV.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionCell
        return CGFloat(90+(125+20) * (cell.data.count+1))
    }
}


