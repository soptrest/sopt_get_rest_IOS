//
//  MyPageRule2ViewController.swift
//  GetRestIOS
//
//  Created by 박경선 on 13/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class MyPageRule2ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView_: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView_.sizeToFit()
        textView_.isScrollEnabled = false
    }
}
