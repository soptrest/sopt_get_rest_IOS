//
//  MyPageTheEndViewController.swift
//  GetRestIOS
//
//  Created by 박경선 on 11/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class MyPageTheEndViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordTF: UITextField!
    let border = CALayer()
    let myPasswd: String = "qwer1234"
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTF.delegate = self
        textField.isScrollEnabled = false
        textField.isEditable = false
        doneBtn.isEnabled = false
        doneBtn.backgroundColor = UIColor.buttonInactiveColor
        passwordTF.setBorder(border: border, color: UIColor.borderColor.cgColor)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        border.removeFromSuperlayer()
        passwordTF.setBorder(border: border, color: UIColor.mainGreen.cgColor)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        border.removeFromSuperlayer()
        passwordTF.setBorder(border: border, color: UIColor.borderColor.cgColor)
        if textField.text == myPasswd {
            doneBtn.isEnabled = true
            doneBtn.backgroundColor = UIColor.mainGreen
        } else {
            doneBtn.isEnabled = false
            doneBtn.backgroundColor = UIColor.buttonInactiveColor
        }
    }
    @IBAction func doneAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "", message: "정말 떠날건가요,,,,", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "아뇨", style: .cancel, handler: nil)
        let YesAction = UIAlertAction(title: "넹..", style: .default, handler: nil)
        alert.addAction(noAction)
        alert.addAction(YesAction)
        self.present(alert, animated: true, completion: nil)
    }
}
