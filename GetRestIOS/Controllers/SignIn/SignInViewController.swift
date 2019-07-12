//
//  SignInViewController.swift
//  GetRestIOS
//
//  Created by 박경선 on 08/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var IdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginAction: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginAction.isEnabled = false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"loginBackgroundImg")!)
        IdTextField.delegate = self
        passwordTextField.delegate = self
        loginAction.dropShadow(color: UIColor.shadow, offSet: CGSize(width: 0, height: 3), opacity: 1.0, radius: 5)
        loginAction.roundCorners(corners: [.allCorners], radius: 5)
        loginAction.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if( !IdTextField.text!.isEmpty && !passwordTextField.text!.isEmpty) {
            loginAction.isEnabled = true
            loginAction.tintColor = UIColor.mainGreen
        } else {
            loginAction.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        AuthService.shared.login(IdTextField.text!, passwordTextField.text!) {
            data in
            switch data {
            case .success(let rcvData):
                let model: SignInModel = rcvData as! SignInModel
                UserDefaults.standard.set(model.userToken, forKey: "token")
                UserDefaults.standard.set(model.userIdx, forKey: "userIdx")
                UserDefaults.standard.set(model.userName, forKey: "userName")
                sender.backgroundColor = UIColor(red: 93.0/255.0, green: 139.0/255.0, blue: 49.0/255.0, alpha: 1.0)
                sender.tintColor = UIColor.white
                let homeView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView")
                self.present(homeView, animated: true, completion: nil)
                break
            case .requestErr( _):
                self.simpleAlert(title: "", message: "값을 입력해주세요!")
                break
            case .pathErr:
                self.simpleAlert(title: "", message: "잘못 입력하셨습니다ㅜㅜ")
                break
            case .serverErr:
                print("서버 에러")
                break
            case .networkFail:
                break
            }
        }
    }
    
    @IBAction func autoLoginButton(_ sender: UIButton) {
        sender.backgroundColor = UIColor(red: 93.0/255.0, green: 139.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        sender.tintColor = UIColor.white
        let homeView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView")
        self.present(homeView, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

