//
//  SingUpViewController.swift
//  GetRestIOS
//
//  Created by 박경선 on 07/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var pwCheckLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pwCheckTextField: UITextField!
    @IBOutlet weak var DoneButton: UIButton!
    
    var keyboardShown: Bool = false
    var isEdit: Bool = false
    var alert: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldCheck()
        setNavigationBar()
        alert = UILabel()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "signUpBackground")
        backgroundImage.contentMode = UIView.ContentMode.bottom
        self.view.addSubview(backgroundImage)
        
        //        DoneButton.addTarget(self, action: Selector(("holdRelease:")), for: UIControl.6
        //        Event.touchUpInside);
        //        DoneButton.addTarget(self, action: Selector(("HoldDown:")), for: UIControl.Event.touchDown)
        
        
        DoneButton.isEnabled = false
        DoneButton.roundCorners(corners: [.allCorners], radius: 5)
        //        DoneButton.setBackgroundColor(UIColor.graphBarGray, for: .disabled)
        
        //        self.navigationController?.navigationBar.backItem?.title = " "
        self.navigationController?.navigationBar.tintColor = UIColor.mainColorGreen
        self.navigationController?.navigationBar.backItem?.backBarButtonItem!.title = " "
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    //target functions
    func HoldDown(sender:UIButton) {
        DoneButton.backgroundColor = UIColor.mainColorGreen
    }
    
    func holdRelease(sender:UIButton) {
        DoneButton.backgroundColor = UIColor.graphLineGray
    }
    
    func setNavigationBar(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.shadow.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.1
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.mainColorGreen]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        //        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "  ", style: .plain, target: self, action: #selector(backButtonClick(sender:)))
        UINavigationBar.appearance().barTintColor = UIColor.mainColorGreen
    }
    
    @IBAction func DoneButton(_ sender: UIButton) {

        AuthService.shared.signup(id: idTextField.text!, name: nameTextField.text!, password: passwordTextField.text!) { _ in
            let completeAlert = UIAlertController(title: "", message: "회원가입이 완료되었어요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default) { UIAlertAction in
                self.navigationController?.popViewController(animated: true)
            }
            completeAlert.addAction(action)
            self.present(completeAlert, animated: true, completion: nil)
        }
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[0-9])(?=.*[a-z]).{6,}")
        return passwordTest.evaluate(with: password)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func setTextFieldCheck(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setSignUpTF(tf: nameTextField)
        setSignUpTF(tf: idTextField)
        setSignUpTF(tf: passwordTextField)
        setSignUpTF(tf: pwCheckTextField)
    }
    
    func setSignUpTF(tf: UITextField){
        let borderColor = UIColor(red: 195.0/255.0, green: 195.0/255.0, blue: 195.0/255.0, alpha: 1.0)
        tf.delegate = self
        tf.textColor = UIColor.mainColorGreen
        tf.setBorder(borderColor: borderColor, borderWidth: 1)
        tf.roundCorners(corners: [.allCorners], radius: 5)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(!isPasswordValid(passwordTextField.text!) && (textField == passwordTextField)){
            passwordLabel.text = "영어 + 숫자 조합으로 6자 이상 적어주세요!"
            pwCheckLabel.text = "* 비밀번호가 서로 맞지 않아요 ㅜ△ㅜ"
        } else {
            passwordLabel.text = ""
        }
        
        if ((passwordTextField.text != pwCheckTextField.text)){
            pwCheckLabel.text = "* 비밀번호가 서로 맞지 않아요 ㅜ△ㅜ"
        } else {
            pwCheckLabel.text = ""
        }
        
        
        if (!nameTextField.text!.isEmpty && !idTextField.text!.isEmpty && !passwordTextField.text!.isEmpty && !pwCheckTextField.text!.isEmpty && passwordTextField.text == pwCheckTextField.text){
            DoneButton.isEnabled = true
            DoneButton.backgroundColor = UIColor.mainColorGreen
            pwCheckLabel.text = ""
        } else {
            DoneButton.isEnabled = false
            DoneButton.backgroundColor = UIColor(red: 195.0/255.0, green: 195.0/255.0, blue: 195.0/255.0, alpha: 1.0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if( textField == pwCheckTextField || textField == passwordTextField) {
            keyboardShown = true
        } else {
            keyboardShown = false
        }
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if(keyboardShown){
            self.view.frame.origin.y = -150
            isEdit = true
        }
    }
    
    @objc func keyboardWillHide(_ notification:NSNotification) {
        if( isEdit ){
            self.view.frame.origin.y = 0
            isEdit = false
        }
    }
}


extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(backgroundImage, for: state)
    }
}

extension UITextField {
    func dataCheck(view: UIView, identifyLabel label: UILabel, text: String){
        let frame = CGRect(x: label.frame.maxX, y: label.frame.minY + 64, width: 250, height: label.frame.height)
        let alert = UILabel(frame: frame)
        alert.frame = frame
        alert.font = UIFont.systemFont(ofSize: 14)
        alert.backgroundColor = UIColor.white
        if( self.text == "" ){
            alert.textColor = UIColor(red: 188.0/255.0, green: 66.0/255.0, blue: 66.0/255.0, alpha: 1.0)
            alert.text = text
        }
        else {
            alert.text = ""
        }
        view.addSubview(alert)
    }
}
