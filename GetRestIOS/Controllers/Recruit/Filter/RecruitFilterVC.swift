//
//  RecruitFilterVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 09/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class RecruitFilterVC: UIViewController {

    @IBOutlet var navBar: UINavigationBar!
    var model: [[String]] = []
    var storedOffsets = [Int: CGFloat]()
    var sections: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func closeAction(_ sender: UIBarButtonItem) {
        // 데이터 넘겨주기 및 통신필요?
        dismiss(animated: true)
    }
    
        
}
extension RecruitFilterVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FliterList",for: indexPath) as! FIlterListTVC
        cell.backgroundColor = .blue
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 1:
            return sections[section]
        case 2:
            return sections[section]
        case 3:
            return sections[section]
        default:
            return ""
        }
    }
}

//extension RecruitFilterVC: UITableViewDelegate, UITableViewDataSource  {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return model.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FliterList",for: indexPath)
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let tableViewCell = cell as? FIlterListTVC else { return }
//        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self as UICollectionViewDataSource & UICollectionViewDelegate, forRow: indexPath.row)
//    }
//}
//
//extension RecruitFilterVC: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return model[collectionView.tag].count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterListCell", for: indexPath) as! FIlterListCellCVC
//
//        cell.filterCellBtn.setTitle(model[collectionView.tag][indexPath.item], for: .normal)
//
//        return cell
//    }
//
//
//}
extension RecruitFilterVC {
    func setData() {
        sections = ["채용형태", "희망근무지역", "관심분야"]
        let cell1: [String] = ["경력무관", "신입", "정규직", "계약직", "인턴직"]
        let cell2: [String] = ["전국", "서울", "경기", "인천", "부산", "대구", "광주", "대전", "울산", "세종", "강원", "경남", "경북", "전남", "전북", "충남", "충북", "제주"]
        let cell3: [String] = ["전체", "경영·사무", "영업·고객상담", "디자인", "IT·인터넷", "전문직"]
        model = [cell1, cell2, cell3]
    }
}


