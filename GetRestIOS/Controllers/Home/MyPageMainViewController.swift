//
//  MyPageMainViewController.swift
//  GetRestIOS
//
//  Created by 박경선 on 11/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class MyPageMainViewController: UIViewController {

    @IBOutlet weak var topSideView: UIView!
    @IBOutlet weak var topSideLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UILabel!
    
    let username: String = "박경선"
    let userID: String = "gngsn"
    let border = CALayer()
    let width = CGFloat(1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        topSideView.backgroundColor = UIColor(patternImage: UIImage(named: "imgMyPage")!)
        topSideView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 28)
        topSideLabel.attributedText = NSMutableAttributedString()
            .bold(username, fontSize: 20)
            .normal("님", fontSize: 17)
        idTextField.text = userID
        self.navigationItem.title = "마이페이지"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.mainGreen]
        navigationController?.navigationBar.barTintColor = UIColor.mainGreen
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = UIColor.white
        
        nameTextField.setBorder(border: border, color: UIColor.borderColor.cgColor)
        nameTextField.text = username
    }
    
    @IBAction func goPasswordChangeView(_ sender: Any) {
        let dvc = (self.storyboard?.instantiateViewController(withIdentifier: "pwdChangeView"))!
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension MyPageMainViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        border.removeFromSuperlayer()
        textField.setBorder(border: border, color: UIColor.mainGreen.cgColor)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        border.removeFromSuperlayer()
        textField.setBorder(border: border, color: UIColor.borderColor.cgColor)
    }
}


