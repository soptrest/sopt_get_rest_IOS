//
//  PortfolioDetailVC2.swift
//  GetRestIOS
//
//  Created by 최리안 on 06/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PortfolioDetailVC2: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var label: UILabel!
    var tabTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        label.text = tabTitle
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "\(tabTitle)")
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
