//
//  DatepickerStartEndVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 12/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class DatepickerStartEndVC: UIViewController {

    @IBOutlet var startDateView: UIView!
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateView: UIView!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var endLabel: UILabel!
    @IBOutlet var datePickerView: UIDatePicker!
    @IBOutlet var cancle: UIButton!
    @IBOutlet var confirm: UIButton!
    
    var StartViewIsSelected : Bool = true
    var formmatedDate: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "ko_KO") as Locale;
            dateFormatter.dateFormat = "yyyy.MM.dd"
            dateFormatter.dateStyle = .medium
            print((startDateLabel.text! + " ~ " + endDateLabel.text!))
            return (startDateLabel.text! + " ~ " + endDateLabel.text!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         datePickerView.addTarget(self, action: #selector(datePickerIsChanged(picker:)), for: .valueChanged)
        let gestureStart = UITapGestureRecognizer(target: self, action: #selector(DatepickerStartEndVC.dateStartViewSelected(gesture:)))
        self.startDateView.addGestureRecognizer(gestureStart)
        let gestureEnd = UITapGestureRecognizer(target: self, action: #selector(DatepickerStartEndVC.dateEndViewSelected(gesture:)))
        self.endDateView.addGestureRecognizer(gestureEnd)
        
        setFirstPickerDateLable()
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ko_KO") as Locale
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.dateStyle = .medium
        let start = dateFormatter.date(from: startDateLabel.text!)
        let end = dateFormatter.date(from: endDateLabel.text!)
        
        if start?.compare(end!) == .orderedDescending{
            let alert = UIAlertController(title: "날짜 입력이 잘못되었습니다", message: "다시 입력하세요!!", preferredStyle: UIAlertController.Style.alert)
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil)
            alert.addAction(defaultAction)
            present(alert, animated: false, completion: nil)
        }  else {
            NotificationCenter.default.post(name: .PortfolioDate, object: self)
            dismiss(animated: true)
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }

    
    @objc func datePickerIsChanged(picker:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ko_KO") as Locale
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.dateStyle = .medium
        
        if(StartViewIsSelected){
            startDateLabel.text = dateFormatter.string(from: picker.date)
        }else{
            endDateLabel.text = dateFormatter.string(from: picker.date)
        }
    }
    @objc func dateEndViewSelected(gesture : UITapGestureRecognizer){
        startDateView.backgroundColor = .datePickerGray
        endDateView.backgroundColor = .white
        StartViewIsSelected = false
    }
    @objc func dateStartViewSelected(gesture : UITapGestureRecognizer){
        startDateView.backgroundColor = .white
        endDateView.backgroundColor = .datePickerGray
        StartViewIsSelected = true
    }
    
    func setFirstPickerDateLable(){
        let nowDateTime = Date();

        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ko_KO") as Locale
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.dateStyle = .medium

        startDateLabel.text = dateFormatter.string(from: nowDateTime)
        endDateLabel.text = dateFormatter.string(from: nowDateTime)

//        let pickerDateString = "\((startDateLabel.text)!)"
        let pickerDateString = (startDateLabel.text)!

        let pickerDate = dateFormatter.date(from: pickerDateString)
        datePickerView.date = pickerDate!
    }
}

//@objc func dateEndViewSelected(gesture : UITapGestureRecognizer){
//    startDateView.backgroundColor = .datePickerGray
//    endDateView.backgroundColor = .white
//    //        if let _ = endDateLabel.text?.isEmpty {
//    //            let dateFormatter = DateFormatter()
//    //            dateFormatter.locale = NSLocale(localeIdentifier: "ko_KO") as Locale
//    //            dateFormatter.dateFormat = "yyyy-MM-dd"
//    //            dateFormatter.dateStyle = .medium
//    //            let dateString = "\((endDateLabel.text)!)"
//    //            let date = dateFormatter.date(from: dateString)
//    //            datePickerView.date = date!
//    //        }else{
//    //
//    //        }
//    StartViewIsSelected = false;
//    //        startDateView.isUserInteractionEnabled = true;
//    //        endDateView.isUserInteractionEnabled = false;
//}
