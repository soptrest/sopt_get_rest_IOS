//
//  RecruitDetailVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 09/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class RecruitDetailVC: UIViewController {
    
    @IBOutlet var corprImg: UIImageView!
    @IBOutlet var corporNameLabel: UILabel!
    @IBOutlet var corporFieldLabel: UILabel!
    @IBOutlet var corporDurationLabel: UILabel!
    @IBOutlet var careerLabel: UILabel!
    @IBOutlet var academicLabel: UILabel!
    @IBOutlet var serviceLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var areaLabel: UILabel!
    @IBOutlet var detailBackground: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        self.navigationItem.title = "상세정보"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.barMainGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        detailBackground.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 28)
        detailBackground.dropShadow(color: UIColor.black, offSet: CGSize(width: 0, height: 10), opacity: 1, radius: 28)

    }
    @IBAction func writeAction(_ sender: UIButton) {
    }
    @IBAction func goHomepageAction(_ sender: UIButton) {
    }
    
}

extension RecruitDetailVC {
    func setLabel() {
        corporNameLabel.sizeToFit()
        corporFieldLabel.sizeToFit()
        corporDurationLabel.sizeToFit()
        careerLabel.sizeToFit()
        academicLabel.sizeToFit()
        serviceLabel.sizeToFit()
        positionLabel.sizeToFit()
        areaLabel.sizeToFit()
    }
}
