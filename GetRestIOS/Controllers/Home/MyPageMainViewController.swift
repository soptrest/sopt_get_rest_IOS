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
        

        border.borderColor = UIColor(red: 162.0/255.0, green: 162.0/255.0, blue: 162.0/255.0, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: nameTextField.frame.size.height - width, width:  nameTextField.frame.size.width, height: nameTextField.frame.size.height)
        border.borderWidth = width
        nameTextField.layer.addSublayer(border)
        nameTextField.borderStyle = .none
        nameTextField.layer.masksToBounds = true
        nameTextField.text = username
        nameTextField.tintColor = .black
    }
}

extension MyPageMainViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        border.removeFromSuperlayer()
        border.borderColor = UIColor.mainGreen.cgColor
        border.frame = CGRect(x: 0, y: nameTextField.frame.size.height - width, width:  nameTextField.frame.size.width, height: nameTextField.frame.size.height)
        border.borderWidth = width
        nameTextField.layer.addSublayer(border)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        border.removeFromSuperlayer()
        border.borderColor =  UIColor(red: 162.0/255.0, green: 162.0/255.0, blue: 162.0/255.0, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: nameTextField.frame.height - width, width:  nameTextField.frame.width, height: nameTextField.frame.height)
        border.borderWidth = width
        nameTextField.layer.addSublayer(border)
    }
}
