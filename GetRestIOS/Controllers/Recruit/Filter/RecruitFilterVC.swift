//
//  RecruitFilterVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 09/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RecruitFilterVC: ButtonBarPagerTabStripViewController {

    var model: [[String]] = []
    var storedOffsets = [Int: CGFloat]()
    var sections: [String] = []
    
    override func viewDidLoad() {
        configureButtonBar()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        //管理されるViewControllerを返す処理
        let tab1 = UIStoryboard(name: "Recruit", bundle: nil).instantiateViewController(withIdentifier: "FilterTab") as! FilterTabBarVC
        tab1.tabTitle = "채용형태"
        tab1.tabRow = 1
        let tab2 = UIStoryboard(name: "Recruit", bundle: nil).instantiateViewController(withIdentifier: "FilterTab") as! FilterTabBarVC
        tab2.tabRow = 2
        tab2.tabTitle = "희망근무지역"
        let tab3 = UIStoryboard(name: "Recruit", bundle: nil).instantiateViewController(withIdentifier: "FilterTab") as! FilterTabBarVC
        tab3.tabRow = 3
        tab3.tabTitle = "관심분야"
        let tabs:[UIViewController] = [tab1, tab2, tab3]
        return tabs
    }
    
    @IBAction func closeAction(_ sender: UIBarButtonItem) {
        // 데이터 넘겨주기 및 통신필요?
        dismiss(animated: true)
    }
    @IBAction func selectAction(_ sender: UIBarButtonItem) {
        // 데이터 넘겨주기 및 통신필요?
        dismiss(animated: true)
    }
    
        
}

extension RecruitFilterVC {
    func setData() {
        sections = ["채용형태", "희망근무지역", "관심분야"]
        let cell1: [String] = ["경력무관", "신입", "정규직", "계약직", "인턴직"]
        let cell2: [String] = ["전국", "서울", "경기", "인천", "부산", "대구", "광주", "대전", "울산", "세종", "강원", "경남", "경북", "전남", "전북", "충남", "충북", "제주"]
        let cell3: [String] = ["전체", "경영·사무", "영업·고객상담", "디자인", "IT·인터넷", "전문직"]
        model = [cell1, cell2, cell3]
    }
    
    func configureButtonBar() {
        // Sets the background colour of the pager strip and the pager strip item
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        
        // Sets the pager strip item font and font color
        settings.style.buttonBarItemFont = UIFont(name: "Apple SD 산돌고딕 Neo", size: 17.0 )!
        settings.style.buttonBarItemTitleColor = .btnBarItemTitleColor
        
        // Sets the pager strip item offsets
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 16
        settings.style.buttonBarRightContentInset = 16
        
        // Sets the height and colour of the slider bar of the selected pager tab
        settings.style.selectedBarHeight = 3.0
        settings.style.selectedBarBackgroundColor = .barMainGreen
        
        //        settings.style.buttonBarHeight = 100
        
        // Changing item text color on swipe
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .btnBarItemTitleColor
            newCell?.label.textColor = .barMainGreen
        }
    }
    
}


