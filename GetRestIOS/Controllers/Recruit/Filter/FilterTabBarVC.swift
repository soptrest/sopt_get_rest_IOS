//
//  FilterTabBarVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 12/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FilterTabBarVC: UIViewController, IndicatorInfoProvider,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
 {
    @IBOutlet var filterCollectionVIew: UICollectionView!
    var tabTitle: String = ""
    var tabRow: Int = 0

    var sections: [String] = []
    var model: [[String]] = []
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model[tabRow-1].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FIlterListCellCVC", for: indexPath) as! FIlterListCellCVC
        cell.filterCellBtn.setTitle(model[tabRow-1][indexPath.row], for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if tabRow == 3 {
            print("ㅋㅋㅋㅋㅋㅋㅋㅋㅋ")
            return CGSize(width: 105, height: 30)
        }
        print("????")
        return CGSize(width: 75, height: 30)
        
    }
    
    
    override func viewDidLoad() {
        
        filterCollectionVIew.delegate = self
        filterCollectionVIew.dataSource = self
        super.viewDidLoad()
        setData()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(tabTitle)")
    }
    
    func setData() {
        sections = ["채용형태", "희망근무지역", "관심분야"]
        let cell1: [String] = ["경력무관", "신입", "정규직", "계약직", "인턴직"]
        let cell2: [String] = ["전국", "서울", "경기", "인천", "부산", "대구", "광주", "대전", "울산", "세종", "강원", "경남", "경북", "전남", "전북", "충남", "충북", "제주"]
        let cell3: [String] = ["전체", "경영·사무", "영업·고객상담", "디자인", "IT·인터넷", "전문직", "서비스", "생산·제조", "의료", "유통·무역", "건설", "교육", "미디어", "특수계층·공공"]
        model = [cell1, cell2, cell3]
    }
    
    
    


}
