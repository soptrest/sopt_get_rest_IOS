//
//  RecruitViewController.swift
//  GetRestIOS
//
//  Created by 최리안 on 08/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit



class RecruitViewController: UIViewController {

    @IBOutlet var recruitListTableView: UITableView!
    @IBOutlet var starFilterBtn: UIButton!
    @IBOutlet var selectDatePickerBtn: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    var list: [RecruitListModel] = []
    var checkedList: [RecruitListModel] = []
    var starIsChecked = false
    
    
    @IBAction func searchAction(_ sender: UIBarButtonItem) {
        let storyboard  = UIStoryboard(name: "Recruit", bundle: nil)
        // 아까 입력했던 storyboard id -> writeview_yw를 입력해주자ㅏ.
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC")
        self.present(vc, animated: false)
    }
    @IBAction func filterAction(_ sender: UIButton) {
        
    }
    @IBAction func starFilterAction(_ sender: UIButton) {

        starIsChecked = !starIsChecked
        if starIsChecked {
            starFilterBtn.setImage(UIImage(named: "icStarFilterOn"), for: .normal)
            
//            for cell in list {
//                if cell.isChecked == true {
//                    checkedList.append(cell)
//                }
//            }
            recruitListTableView.reloadData()

        } else {
            starFilterBtn.setImage(UIImage(named: "icStarFilterOff"), for: .normal)
        }
    }
    override func viewDidLoad() {
        
        recruitListTableView.delegate = self
        recruitListTableView.dataSource = self
        
        super.viewDidLoad()
        
        setNavigationBar()
        loadData()
        setToday()
//        setData()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(RecruitViewController.goPage(sender:)))
        self.selectDatePickerBtn.addGestureRecognizer(gesture)
        
        NotificationCenter.default.addObserver(forName: .RecruitDate, object: nil, queue: OperationQueue.main) { (notification) in
            let dateVc = notification.object as! DatePickerVC
            self.dateLabel.text = dateVc.formmatedDate
        }
    }
    
    func loadData(){
        RecruitService.shared.getAllRecruit(date: "dsdfsd") {
            [weak self]
            data in
            guard let `self` = self else { return }
            switch data {
            case .success(let res):
                self.list = res as! [RecruitListModel]
                self.recruitListTableView.reloadData()
                break
            case .requestErr(let err):
                print(".requestErr(\(err))")
                break
            case .pathErr:
                print("경로 에러")
                break
            case .serverErr:
                print("서버 에러")
                break
            case .networkFail:
                self.alertTimerController(message: "통신 실패 - 네트워크 상태를 확인하세요.", timer: 1)
                break
            }
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let index = recruitListTableView.indexPathForSelectedRow {
            recruitListTableView.deselectRow(at: index, animated: true)
        }
    }
    
    @objc func goPage(sender:UIGestureRecognizer) {
        // Story board 상수를 지정하고 (Main.storyboard 기 때문에 "Main"을 입력해주자.)
        let storyboard  = UIStoryboard(name: "Recruit", bundle: nil)
        // 아까 입력했던 storyboard id -> writeview_yw를 입력해주자ㅏ.
        let vc = storyboard.instantiateViewController(withIdentifier: "DatePicker")
        self.present(vc, animated: true)
    }
}

extension RecruitViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recruitListTableView.dequeueReusableCell(withIdentifier: "RecruitListTableViewCell") as! RecruitListCell
        
        let data = list[indexPath.row]
        
        cell.recruitTitle.text = data.companyName
        cell.recruitField.text = data.recruitJobCategory
        cell.recruitDate.text = data.recruitExpireDate
        cell.recruitImg.image = UIImage(named: data.companyImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let dvc = storyboard?.instantiateViewController(withIdentifier: "RecruitDetailVC") as! RecruitDetailVC
        
//                present(dvc, animated: true)
                navigationController?.pushViewController(dvc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension RecruitViewController {
    func setNavigationBar(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 62, height: 17))
        imageView.contentMode = .scaleAspectFit
        
        let image = UIImage(named: "icRecruit")
        imageView.image = image
        
        self.navigationItem.titleView = imageView
        self.navigationController?.navigationBar.tintColor = .barMainGreen
        self.navigationController?.navigationBar.clipsToBounds = true
        
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        self.navigationController?.navigationBar.clipsToBounds = true
        
    }
    
    func setToday() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ko_KO") as Locale;
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateStyle = .medium
        let today = formatter.string(from: date)
        
        self.dateLabel.text = today
    }
    
    func setData() {
//        let rc1 = RecruitListModel(img: "icDefaultImg", title: "솝트1", field: "Web 디자이너 / 모바일. App 디자이너", date: "~06월 19일 18시 00분")
//        let rc2 = RecruitListModel(img: "icDefaultImg", title: "솝트2", field: "Web 디자이너 / 모바일. App 디자이너", date: "~06월 19일 18시 00분")
//        let rc3 = RecruitListModel(img: "icDefaultImg", title: "솝트3", field: "Web 디자이너 / 모바일. App 디자이너", date: "~06월 19일 18시 00분")
//        let rc4 = RecruitListModel(img: "icDefaultImg", title: "솝트4", field: "Web 디자이너 / 모바일. App 디자이너", date: "~06월 19일 18시 00분")
//        let rc5 = RecruitListModel(img: "icDefaultImg", title: "솝트5", field: "Web 디자이너 / 모바일. App 디자이너", date: "~06월 19일 18시 00분")
//        let rc6 = RecruitListModel(img: "icDefaultImg", title: "솝트6", field: "Web 디자이너 / 모바일. App 디자이너", date: "~06월 19일 18시 00분")
//        let rc7 = RecruitListModel(img: "icDefaultImg", title: "솝트7", field: "Web 디자이너 / 모바일. App 디자이너", date: "~06월 19일 18시 00분")
//        let rc8 = RecruitListModel(img: "icDefaultImg", title: "솝트8", field: "Web 디자이너 / 모바일. App 디자이너", date: "~06월 19일 18시 00분")
        
//        list = [rc1, rc2, rc3, rc4, rc5, rc6, rc7, rc8]
//        checkedList = [rc1, rc2, rc3, rc4, rc5, rc6, rc7, rc8]
    }
}

