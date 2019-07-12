//
//  PortfolioSelectVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 11/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//


import UIKit
import XLPagerTabStrip

class PortfolioSelectVC:  ButtonBarPagerTabStripViewController {
    override func viewDidLoad() {
        configureButtonBar()
        
        super.viewDidLoad()
        setNavigationBar()
        
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Configuration
    
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let tab1 = UIStoryboard.init(name: "Recruit", bundle: nil).instantiateViewController(withIdentifier: "SelectTabBar1") as! SelectTabBarVC1
        tab1.tabTitle = "전체"
        
        let tab2 = UIStoryboard.init(name: "Recruit", bundle: nil).instantiateViewController(withIdentifier: "SelectTabBar1") as! SelectTabBarVC1
        tab2.tabTitle = "대외활동"
        
        let tab3 = UIStoryboard.init(name: "Recruit", bundle: nil).instantiateViewController(withIdentifier: "SelectTabBar2") as! SelectTabBarVC2
        tab3.tabTitle = "학교활동"
        
        let tab4 = UIStoryboard.init(name: "Recruit", bundle: nil).instantiateViewController(withIdentifier: "SelectTabBar2") as! SelectTabBarVC2
        tab4.tabTitle = "공모전"
        
        let tab5 = UIStoryboard.init(name: "Recruit", bundle: nil).instantiateViewController(withIdentifier: "SelectTabBar2") as! SelectTabBarVC2
        tab5.tabTitle = "경력사항"
        
        let tab6 = UIStoryboard.init(name: "Recruit", bundle: nil).instantiateViewController(withIdentifier: "SelectTabBar2") as! SelectTabBarVC2
        tab6.tabTitle = "기타"
        
        return [tab1, tab2, tab3, tab4, tab5, tab6]
    }
    
    @IBAction func closeAction(_ sender: UIBarButtonItem) {
        // 데이터 넘겨주기 및 통신필요?
        dismiss(animated: true)
    }
    @IBAction func selectAction(_ sender: UIBarButtonItem) {
        // 데이터 넘겨주기 및 통신필요?
        dismiss(animated: true)
    }
    
//    @IBAction func addBtn(_ sender: Any) {
//        
//        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "AddPortfolioViewController") as? AddPortfolioViewController
//            else {
//                return
//        }
//        
//        //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
//        navigationController?.pushViewController(dvc, animated: true)
//    }
        
}

extension PortfolioSelectVC {
    func setNavigationBar(){
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        navigationController?.navigationBar.isTranslucent = false
        
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 78, height: 17))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "icPortfolio")
        imageView.image = image
        
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.tintColor = .barMainGreen
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.navigationBar.clipsToBounds = true
        
        let backBarButtton = UIBarButtonItem(title: "기록보기", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
    }
    
}

extension PortfolioSelectVC {
//    func setData() {
//        sections = ["채용형태", "희망근무지역", "관심분야"]
//        let cell1: [String] = ["경력무관", "신입", "정규직", "계약직", "인턴직"]
//        let cell2: [String] = ["전국", "서울", "경기", "인천", "부산", "대구", "광주", "대전", "울산", "세종", "강원", "경남", "경북", "전남", "전북", "충남", "충북", "제주"]
//        let cell3: [String] = ["전체", "경영·사무", "영업·고객상담", "디자인", "IT·인터넷", "전문직"]
//        model = [cell1, cell2, cell3]
//    }
    
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


