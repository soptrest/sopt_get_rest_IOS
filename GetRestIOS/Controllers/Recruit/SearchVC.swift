//
//  SearchVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 09/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet var dismissView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(RecruitViewController.goPage(sender:)))
        self.dismissView.addGestureRecognizer(gesture)

        // Do any additional setup after loading the view.
    }
    
    @objc func goPage(sender:UIGestureRecognizer) {

        dismiss(animated: false)
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
