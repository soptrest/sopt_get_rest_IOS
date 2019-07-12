//
//  MyResumeListViewController.swift
//  GetRestIOS
//
//  Created by 박경선 on 08/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class MyResumeListViewController: UIViewController {
    
    var dataList: [MyResumeListModel] = []
//        MyResumeListModel(3, "네이버", "Web 디자이너 / 모바일. App 디자이너"),
//        MyResumeListModel(5, "네이버", "Web 디자이너 / 모바일. App 디자이너"),
//        MyResumeListModel(2, "네이버", "Web 디자이너 / 모바일. App 디자이너"),
//        MyResumeListModel(11, "가나다", "Web 디자이너 / 모바일. App 디자이너"),
//        MyResumeListModel(34, "네이버", "Web 디자이너 / 모바일. App 디자이너"),
//        MyResumeListModel(2, "네이버", "Web 디자이너 / 모바일. App 디자이너"),
//    ]
    var isDeleteMode: Bool = false
    @IBOutlet weak var resumeTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListData()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.mainColorGreen
        resumeTV.delegate = self
        resumeTV.dataSource = self
    }
    
    func getListData(){
        MyResumeService.shared.getAllResume() {
            data in
            switch data {
            case .success(let rcvData):
                self.dataList = rcvData as! [MyResumeListModel]
                self.resumeTV.reloadData()
                break
            case .requestErr( _):
//                self.simpleAlert(title: "", message: "값을 입력해주세요!")
                break
            case .pathErr:
//                self.simpleAlert(title: "", message: "잘못 입력하셨습니다ㅜㅜ")
                break
            case .serverErr:
                print("서버 에러")
                break
            case .networkFail:
                break
            }
        }
    }
    
    @IBAction func trashAction(_ sender: UIBarButtonItem) {
        isDeleteMode = !isDeleteMode
        if isDeleteMode {
            
            sender.image = UIImage(named: "btnDone")
            resumeTV.allowsMultipleSelection = true
        } else {
            sender.image = UIImage(named: "btnTrash")
            
            if let selectedCells = resumeTV.indexPathsForSelectedRows {
                let rows: [Int] = selectedCells.map{$0.row}
                print(rows)
                for row in rows.sorted(by: >) {
                    print(row)
                    dataList.remove(at: row)
                }
            }
            resumeTV.allowsMultipleSelection = false
        }
        resumeTV.reloadData()
    }
}

extension MyResumeListViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isDeleteMode {
            let dvc = self.storyboard!.instantiateViewController(withIdentifier: "myResumeDetailView")
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myResumeTVC") as! MyResumeTableViewCell
        
        let date: String = String(dataList[indexPath.row].leftDate)
        cell.date.text = "D-\(date)"
        cell.jobTitle.text = dataList[indexPath.row].companyName
        cell.jobType.text = dataList[indexPath.row].recruitJobType
        cell.isDeleteMode = isDeleteMode
        return cell
    }
}
