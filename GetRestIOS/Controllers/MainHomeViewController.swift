//
//  MainHomeViewController.swift
//  GetRestIOS
//
//  Created by 박경선 on 30/06/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class MainHomeViewController: UIViewController {
    
    @IBOutlet weak var topSideView: UIView!
    @IBOutlet weak var TopSideLabel: UILabel!
    
    var username: String = "박경선"
    
    //    let fontSize = UIFont.boldSystemFont(ofSize: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        
        navigationController?.navigationBar.barTintColor = UIColor.mainGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        topSideView.backgroundColor = UIColor.mainGreen
        topSideView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 28)
        
        TopSideLabel.text = "\(username)님의\n기록을 살펴볼까요?"
        TopSideLabel.numberOfLines = 0
        // Do any additional setup after loading the view.
    }
    
    func attributedText(withString string: String, boldString: String, font: UIFont) -> String {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString.string
    }
    
}
