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
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.mainGreen
        navigationController?.navigationBar.isTranslucent = false
        
        topSideView.backgroundColor = UIColor.mainGreen
        topSideView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 28)

        // Do any additional setup after loading the view.
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
