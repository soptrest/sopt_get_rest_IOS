//
//  DatePickerVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 09/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class DatePickerVC: UIViewController {

    
    
//    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    
    var formmatedDate: String {
        get {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "ko_KO") as Locale;
            formatter.dateFormat = "yyyy.MM.dd"
            formatter.dateStyle = .medium
            return formatter.string(from: datePicker.date)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        NotificationCenter.default.post(name: .RecruitDate, object: self)
        
        
        dismiss(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
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
