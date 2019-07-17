//
//  AddPortfolioDetailVC.swift
//  GetRestIOS
//
//  Created by 최리안 on 17/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class AddPortfolioDetailVC: UITableViewController {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var cateBtnClick: UIView!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var durationLabel: UILabel!
//    @IBOutlet weak var hashTagsCollectionView: UICollectionView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backImg: UIView!
    var height: CGFloat = 0.0
    var a: Int = 10
    
    let picker = UIImagePickerController()
    
    // sizeToFit을 주석처리함 --> 이걸 살려두면 글 작성이 불가능 하다
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        setNavigationBar()
        setTableData()
//        setCollectionView()
        height = contentTextView.contentSize.height
        setHeight()
        
        // 카테고리 모달 제스쳐
        let gestureBtn = UITapGestureRecognizer(target: self, action: #selector(AddPortfolioDetailVC.goCategory(sender:)))
        self.cateBtnClick.addGestureRecognizer(gestureBtn)
        // 카테고리 값 가져옴
        NotificationCenter.default.addObserver(forName: .CategoryData, object: nil, queue: OperationQueue.main) { (notification) in
            let cate = notification.object as! CategoryVC
            self.categoryLabel.text = cate.ll
            self.a = cate.selectCate
            if self.a != 10 {
                self.categoryLabel.textColor = .black
            }
            print("a", self.a)
        }
        // 데이트 값 가져옴
        NotificationCenter.default.addObserver(forName: .PortfolioDate, object: nil, queue: OperationQueue.main) { (notification) in
            let dateVc = notification.object as! DatepickerStartEndVC
            self.durationLabel.text = dateVc.formmatedDate
            self.durationLabel.textColor = .black
        }
        
        // 이미지 삽입 제스쳐
        let gestureImg = UITapGestureRecognizer(target: self, action: #selector(AddPortfolioDetailVC.getImg(sender:)))
        self.backImg.addGestureRecognizer(gestureImg)

    }
    
    @objc func goCategory(sender:UIGestureRecognizer) {
        let storyboard  = UIStoryboard(name: "Portfolio", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        vc.selectCate = self.a
        self.present(vc, animated: true)
    }
    
    @objc func getImg(sender:UIGestureRecognizer) {
        let alert =  UIAlertController(title: "사진 추가", message: "사진을 선택해주세요", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
}

extension AddPortfolioDetailVC {
    func setNavigationBar() {
        self.navigationItem.title = ""
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.mainGreen]
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.mainGreen
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = UIColor.white
        
        let rightBtn = UIBarButtonItem(image: UIImage(named: "icSavePofo"), style: .plain, target: self, action: #selector(buttonPressed(_:)))
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    @objc private func buttonPressed(_ sender: UIBarButtonItem) {
        print("저장버튼 누르심!!")
    }
    
    func setTableData(){
        // 내용에 따라 테이블 셀 높이 지정  ( 40은 gap )
        contentView.frame.size.height = contentTextView.frame.height + 40
        contentTextView.isScrollEnabled = false
        var frame = self.contentTextView.frame
        frame.size.height = self.contentTextView.contentSize.height
        self.contentTextView.frame = frame
        
        // 테이블 뷰 크기 조정
        let tableViewImageView = UIImageView(image: UIImage(named: "portfolioTestImg"))
        tableViewImageView.contentMode = .top
        self.tableView.backgroundView = tableViewImageView
        self.tableView.estimatedRowHeight = 174
        self.tableView.rowHeight = UITableView.automaticDimension
        
        contentTextView.delegate = self as? UITextViewDelegate
        contentTextView.translatesAutoresizingMaskIntoConstraints = true
//        contentTextView.sizeToFit()
        contentTextView.isScrollEnabled = false
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        cell.frame.size.height = 1000
    }
    func setHeight(){
//        contentTextView.sizeToFit()
        contentView.frame.size.height = contentTextView.contentSize.height + 50
        tableView.reloadData()
    }
    
    // 카메라 불러오기
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
        }
    }
    
}

extension AddPortfolioDetailVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            let backImageView = UIImageView(image: image)
            backImageView.contentMode = .scaleAspectFill
            self.tableView.backgroundView = backImageView
            self.tableView.estimatedRowHeight = 174
            self.tableView.rowHeight = UITableView.automaticDimension
            
            contentTextView.delegate = self as? UITextViewDelegate
            contentTextView.translatesAutoresizingMaskIntoConstraints = true
//            contentTextView.sizeToFit()
            contentTextView.isScrollEnabled = false
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
}


