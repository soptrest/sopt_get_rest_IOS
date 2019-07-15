//
//  PortfolioDetailVC1.swift
//  GetRestIOS
//
//  Created by 최리안 on 06/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PortfolioDetailVC1: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet var portfolioTableView: UITableView!
    
    var tabTitle: String = ""
    var list: [PortfolioListModel] = []

    
    override func viewDidLoad() {
        
        portfolioTableView.delegate = self
        portfolioTableView.dataSource = self
        
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "PortfolioTableViewCell", bundle: nil)
        portfolioTableView.register(nibName, forCellReuseIdentifier: "PortfolioCell")
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(tabTitle)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let index = portfolioTableView.indexPathForSelectedRow {
            portfolioTableView.deselectRow(at: index, animated: true)
        }
    }
    
    func loadData(){
        PortfolioService.shared.getAllPortfolio() {
            data in
            switch data {
            case .success(let rcvData):
                self.list = rcvData as! [PortfolioListModel]
                self.portfolioTableView.reloadData()
                break
            case .requestErr( _):
                self.simpleAlert(title: "", message: "값을 입력해주세요!")
                break
            case .pathErr:
                self.simpleAlert(title: "", message: "잘못 입력하셨습니다ㅜㅜ")
                break
            case .serverErr:
                print("서버 에러")
                break
            case .networkFail:
                break
            }
        }
    }
}

extension PortfolioDetailVC1: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 145
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = portfolioTableView.dequeueReusableCell(withIdentifier: "PortfolioCell", for: indexPath) as! PortfolioTableViewCell
        
        let data = list[indexPath.row]
        
        
        cell.portfolioTitle.text = data.portfolioTitle
        cell.portfolioDate.text = "\(data.portfolioStartDate) ~ \(data.portfolioExpireDate)"
        cell.portfolioImg.imageFromUrl(gsno(data.portfolioImg), defaultImgPath: "icImg")
        cell.tagList = ["대학생","쉬자","SOPT"]
//        cell.dropShadow(color: .black, offSet: CGSize(width: 0,height: 0), opacity: 0.5, radius: 5)
//        cell.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "homeDetailView") as! PortfolioDetailTableViewController
//        dvc.detailIdx =  list[indexPath.row].portfolioIdx
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    
}

