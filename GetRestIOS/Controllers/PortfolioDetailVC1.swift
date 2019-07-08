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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 160
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = portfolioTableView.dequeueReusableCell(withIdentifier: "PortfolioCell", for: indexPath) as! PortfolioTableViewCell
        
        let data = list[indexPath.row]
        
        if indexPath.row == 1 {
            cell.backgroundColor = .black
            
        }
        cell.portfolioTitle.text = data.pfTitle
        cell.portfolioDate.text = data.pfDate
        cell.portfolioImg.image = data.pfImg
//        cell.portfolioTitle.sizeToFit()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let dvc = storyboard?.instantiateViewController(withIdentifier: "") as!
        
//        let music = musicList[indexPath.row]
//
//        dvc.albumImg = music.albumImg
//        dvc.musicTitle = music.musicTitle
//        dvc.singer = music.singer
//
//        present(dvc, animated: true)
        //        navigationController?.pushViewController(dvc, animated: true)
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        /*
         테이블 뷰 의 row 를 변화시키면 그에 따라 대응되는 모델(데이터)도 변화시켜주어야 합니다.
         sourceIndexPath와 destinationIndexPath를 통해 이동을 시작한 index와 새롭게 설정된 index를 가져올 수 있습니다.
         */
        let movingIndex = list[sourceIndexPath.row]

        list.remove(at: sourceIndexPath.row)
        list.insert(movingIndex, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
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

