//
//  MyPageChangePwViewController.swift
//  GetRestIOS
//
//  Created by 박경선 on 11/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class MyPageChangePwViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var pwCheckTF: UITextField!
    
    @IBOutlet weak var passwordDeleteBtn: UIButton!
    @IBOutlet weak var pwCheckDeleteBtn: UIButton!
    
    @IBOutlet weak var changeBtn: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    let pwBorder = CALayer()
    let pwCheckBorder = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordDeleteBtn.setImage(UIImage(), for: .normal)
        pwCheckDeleteBtn.setImage(UIImage(), for: .normal)
        
        textView.sizeToFit()
        textView.isScrollEnabled = false
        
        passwordTF.delegate = self
        pwCheckTF.delegate = self
        
        changeBtn.isEnabled = false
        changeBtn.roundCorners(corners: [.allCorners], radius: 5)
        
        passwordTF.setBorder(border: pwBorder, color: UIColor.borderColor.cgColor)
        pwCheckTF.setBorder(border: pwCheckBorder, color: UIColor.borderColor.cgColor)
        changeBtn.backgroundColor = UIColor.buttonInactiveColor
    }
    
    
    @IBAction func changeButton(_ sender: UIButton) {
        // 비밀번호 바꾸는 통신
        self.alertTimerController(message: "비밀번호가 성공적으로 변경되었어요!", timer: 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func deleteTextAction(_ sender: UIButton) {
        if( sender == passwordDeleteBtn ){
            passwordTF.text = ""
        } else {
            pwCheckTF.text = ""
        }
        changeBtn.isEnabled = false
        sender.setImage(UIImage(), for: .normal)
        changeBtn.backgroundColor = UIColor.buttonInactiveColor
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("passwordTF.text  : " + passwordTF.text!)
        print("pwCheckTF  : " + pwCheckTF.text!)
        if(passwordTF.text != ""){
            passwordDeleteBtn.setImage(UIImage(named: "btnTextDelete"), for: .normal)
            passwordDeleteBtn.isEnabled = true
            pwBorder.removeFromSuperlayer()
            passwordTF.setBorder(border: pwBorder, color: UIColor.borderColor.cgColor)
        } else {
            passwordDeleteBtn.setImage(UIImage(), for: .normal)
            passwordDeleteBtn.isEnabled = false
            pwBorder.removeFromSuperlayer()
            passwordTF.setBorder(border: pwBorder, color: UIColor.borderColor.cgColor)
        }
        if(pwCheckTF.text != ""){
            pwCheckDeleteBtn.setImage(UIImage(named: "btnTextDelete"), for: .normal)
            pwCheckDeleteBtn.isEnabled = true
            pwCheckBorder.removeFromSuperlayer()
            pwCheckTF.setBorder(border: pwCheckBorder, color: UIColor.borderColor.cgColor)
        } else {
            pwCheckDeleteBtn.setImage(UIImage(), for: .normal)
            pwCheckDeleteBtn.isEnabled = false
            pwCheckBorder.removeFromSuperlayer()
            pwCheckTF.setBorder(border: pwCheckBorder, color: UIColor.borderColor.cgColor)
        }
        
        if( isPasswordValid(passwordTF.text!) && (passwordTF.text == pwCheckTF.text) ){
            changeBtn.isEnabled = true
            changeBtn.backgroundColor = UIColor.mainColorGreen
        } else {
            changeBtn.isEnabled = false
            changeBtn.backgroundColor = UIColor.buttonInactiveColor
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let color: CGColor = UIColor.mainGreen.cgColor
        if ( textField == passwordTF ){
            pwBorder.removeFromSuperlayer()
            passwordTF.setBorder(border: pwBorder, color: color)
        } else {
            pwCheckBorder.removeFromSuperlayer()
            pwCheckTF.setBorder(border: pwCheckBorder, color: color)
        }
        return true
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[0-9])(?=.*[a-z]).{8,16}")
        return passwordTest.evaluate(with: password)
    }
}

extension UITextField {
    func setBorder( border: CALayer, color: CGColor){
        border.borderColor = color
        border.borderWidth = 1.0
        border.frame = CGRect(x: 0, y: self.frame.height - 1.0, width:  self.frame.width, height: self.frame.height)
        self.layer.addSublayer(border)
        self.borderStyle = .none
        self.layer.masksToBounds = true
        UITextField.appearance().tintColor = UIColor.mainGreen
    }
}

extension UIViewController {
    func alertTimerController(message: String, timer: Double) {
        let alert = UIAlertController(title: "", message: "비밀번호가 성공적으로 변경되었어요!", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        // 알람 1초 뒤에 없애줌
        let when = DispatchTime.now() + timer
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

