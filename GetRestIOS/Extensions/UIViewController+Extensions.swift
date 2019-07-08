//
//  UIViewController+Extensions.swift
//  GetRestIOS
//
//  Created by 박경선 on 07/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

extension UIImageView {
    func imageFromUrl(_ urlString: String?) {
        if let url = urlString {
            if url.isEmpty {
                self.image = nil
            } else {
                self.kf.setImage(with: URL(string: url), placeholder: nil, options: [.transition(ImageTransition.fade(0.5))])
            }
        } else {
            self.image = nil
        }
    }
}


extension UITabBarController {
    func hideTabBarAnimated(hide:Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            if hide {
                self.tabBar.transform = CGAffineTransform(translationX: 0, y: 83)
            } else {
                self.tabBar.transform = CGAffineTransform.identity
            }
        })
    }
}
extension UINavigationBar {
    
    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
}

extension UIViewController {
    
    func simpleAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // UIAlertController with Handler
    func simpleAlertwithHandler(title: String, message: String, okHandler : ((UIAlertAction) -> Void)?, cancleHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: cancleHandler)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // Set Custom Back Button
    func setBackBtn(color : UIColor){
        
        // 백버튼 이미지 파일 이름에 맞게 변경해주세요.
        let backBTN = UIBarButtonItem(image: UIImage(named: "backBtn"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(self.pop))
        navigationItem.leftBarButtonItem = backBTN
        navigationItem.leftBarButtonItem?.tintColor = color
        navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
    }
    
    // pop func
    @objc func pop(){
        self.navigationController?.popViewController(animated: true)
    }
    
    // Set NavigationBar Background Clear without underline
    func setNavigationBarClear() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.clear
    }
    
    // Set NavigationBar Background Clear with underline
    func setNavigationBarShadow() {
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.backgroundColor = UIColor.white
    }
    
    func gsno(_ value: String?) -> String{
        guard let value_ = value else {
            return ""
        }
        return value_
    }//func gsno
    
    func gino(_ value: Int?) -> Int{
        guard let value_ = value else {
            return 0
        }
        return value_
    }//func gino
    
    func gbno(_ value: Bool?) -> Bool{
        guard let value_ = value else {
            return false
        }
        return value_
    }//func gbno
    
    func gfno(_ value: Float?) -> Float{
        guard let value_ = value else{
            return 0
        }
        return value_
    }//func gfno
    
}

//extension NetworkManager {
//    //옵셔널 String을 해제하는데 값이 nil이면 ""을 반환
//    func gsno(_ data: String?) -> String {
//        guard let str = data else {
//            return ""
//        }
//        return str
//    }
//
//    //옵셔널 Int를 해제하는데 값이 nil이면 0을 반환
//    func gino(_ data: Int?) -> Int {
//        guard let num = data else {
//            return 0
//        }
//        return num
//    }
//}

extension UIAlertController{
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.tintColor = UIColor(red: 31, green: 191, blue: 200, alpha: 1.0)
    }
}
