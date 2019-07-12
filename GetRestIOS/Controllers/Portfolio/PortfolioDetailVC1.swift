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
    var list: [PortfoliolModel] = []

    
    override func viewDidLoad() {
        
        portfolioTableView.delegate = self
        portfolioTableView.dataSource = self
        
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "PortfolioTableViewCell", bundle: nil)
        portfolioTableView.register(nibName, forCellReuseIdentifier: "PortfolioCell")
        
        setData()
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
        
        cell.portfolioTitle.text = data.pfTitle
        cell.portfolioDate.text = data.pfDate
        cell.portfolioImg.image = data.pfImg
//        cell.dropShadow(color: .black, offSet: CGSize(width: 0,height: 0), opacity: 0.5, radius: 5)
//        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "homeDetailView") as! PortfolioDetailTableViewController
        
//                dvc.albumImg = music.albumImg
//                dvc.musicTitle = music.musicTitle
//                dvc.singer = music.singer
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    
}

extension PortfolioDetailVC1 {
    func setData() {
        let pf1 = PortfoliolModel(img: "icImg", title: "솝트1", date: "2019.03 ~ 2019.07")
        let pf2 = PortfoliolModel(img: "icImg", title: "솝트2", date: "2019.03 ~ 2019.07")
        let pf3 = PortfoliolModel(img: "icImg", title: "솝트3", date: "2019.03 ~ 2019.07")
        let pf4 = PortfoliolModel(img: "icImg", title: "솝트4", date: "2019.03 ~ 2019.07")
        let pf5 = PortfoliolModel(img: "icImg", title: "솝트5", date: "2019.03 ~ 2019.07")
        let pf6 = PortfoliolModel(img: "icImg", title: "솝트6", date: "2019.03 ~ 2019.07")
        let pf7 = PortfoliolModel(img: "icImg", title: "솝트7", date: "2019.03 ~ 2019.07")
        let pf8 = PortfoliolModel(img: "icImg", title: "솝트8", date: "2019.03 ~ 2019.07")
        
        list = [pf1, pf2, pf3, pf4, pf5, pf6, pf7, pf8]
    }
}

