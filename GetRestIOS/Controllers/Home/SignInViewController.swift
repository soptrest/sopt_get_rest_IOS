//
//  SignInViewController.swift
//  GetRestIOS
//
//  Created by 박경선 on 08/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var loginAction: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // 불투명하게 만들기
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"loginBackgroundImg")!)
        
        loginAction.dropShadow(color: UIColor.shadow, offSet: CGSize(width: 0, height: 3), opacity: 1.0, radius: 5)
        loginAction.roundCorners(corners: [.allCorners], radius: 5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func autoLoginButton(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 93.0/255.0, green: 139.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        sender.tintColor = UIColor.white
        let homeView = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeView")
        self.present(homeView, animated: true, completion: nil)
    }
}
