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
    var pfimg: [UIImage?] = [UIImage(named: "icImg"),UIImage(named: "icImg"),UIImage(named: "icImg"),UIImage(named: "icImg"),UIImage(named: "icImg"),UIImage(named: "icImg"),UIImage(named: "icImg")]
    
    var pftitle: [String] = ["sopq1", "sopq2", "sopq5", "sopq6", "sopq9", "sopq10", "sopq11"]
    var pfdate: [String] = ["2019.03 ~ 2019.07", "2019.03 ~ 2019.07", "2019.03 ~ 2019.07", "2019.03 ~ 2019.07","2019.03 ~ 2019.07","2019.03 ~ 2019.07","2019.03 ~ 2019.07"]
   
    @IBOutlet var portfolioTableView: UITableView!
   
    var tabTitle: String = ""

    override func viewDidLoad() {
        
        portfolioTableView.delegate = self
        portfolioTableView.dataSource = self
        
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "PortfolioTableViewCell", bundle: nil)
        portfolioTableView.register(nibName, forCellReuseIdentifier: "PortfolioCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(tabTitle)")
    }



}

extension PortfolioDetailVC1: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pftitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = portfolioTableView.dequeueReusableCell(withIdentifier: "PortfolioCell", for: indexPath) as! PortfolioTableViewCell
        
        cell.portfolioTitle.text = pftitle[indexPath.row]
        cell.portfolioDate.text = pfdate[indexPath.row]
        cell.portfolioImg.image = UIImage(named: "icImg")
        cell.portfolioTitle.sizeToFit()
        
        
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
//        let movingIndex = musicList[sourceIndexPath.row]
//
//        musicList.remove(at: sourceIndexPath.row)
//        musicList.insert(movingIndex, at: destinationIndexPath.row)
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            musicList.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
    
}
