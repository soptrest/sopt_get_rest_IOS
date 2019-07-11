//
//  PortfolioViewController.swift
//  GetRestIOS
//
//  Created by 최리안 on 03/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PortfolioViewController:  ButtonBarPagerTabStripViewController {
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
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let tab1 = UIStoryboard.init(name: "Portfolio", bundle: nil).instantiateViewController(withIdentifier: "PortfolioDetailVC1") as! PortfolioDetailVC1
        tab1.tabTitle = "전체"
        
        let tab2 = UIStoryboard.init(name: "Portfolio", bundle: nil).instantiateViewController(withIdentifier: "PortfolioDetailVC2") as! PortfolioDetailVC2
        tab2.tabTitle = "대외활동"
        
        let tab3 = UIStoryboard.init(name: "Portfolio", bundle: nil).instantiateViewController(withIdentifier: "PortfolioDetailVC1") as! PortfolioDetailVC1
        tab3.tabTitle = "학교활동"
        
        let tab4 = UIStoryboard.init(name: "Portfolio", bundle: nil).instantiateViewController(withIdentifier: "PortfolioDetailVC2") as! PortfolioDetailVC2
        tab4.tabTitle = "공모전"
        
        let tab5 = UIStoryboard.init(name: "Portfolio", bundle: nil).instantiateViewController(withIdentifier: "PortfolioDetailVC1") as! PortfolioDetailVC1
        tab5.tabTitle = "경력사항"
        
        let tab6 = UIStoryboard.init(name: "Portfolio", bundle: nil).instantiateViewController(withIdentifier: "PortfolioDetailVC1") as! PortfolioDetailVC1
        tab6.tabTitle = "기타"
        
        return [tab1, tab2, tab3, tab4, tab5, tab6]
    }
    
    
    @IBAction func addBtn(_ sender: Any) {
        
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "AddPortfolioViewController") as? AddPortfolioViewController
            else {
                return
        }
        
        //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
        navigationController?.pushViewController(dvc, animated: true)
    }
    
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



//class PortfolioViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setNavigationBar()
//
//
//        // Do any additional setup after loading the view.
//    }
//    @IBAction func addBtn(_ sender: Any) {
//
//        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "AddPortfolio") as? AddPortfolioViewController
//            else {
//                return
//        }
//
//        //네비게이션 컨트롤러를 이용하여 push를 해줍니다.
//        navigationController?.pushViewController(dvc, animated: true)
//    }
//
//    func setNavigationBar(){
//        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
//        navigationController?.navigationBar.isTranslucent = false
//
//
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 78, height: 17))
//        imageView.contentMode = .scaleAspectFit
//
//        let image = UIImage(named: "icPortfolio")
//        imageView.image = image
//
//        self.navigationItem.titleView = imageView
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.barTintColor = UIColor.mainGreen
//
//        let backBarButtton = UIBarButtonItem(title: "기록보기", style: .plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backBarButtton
//    }
//
//
//}
