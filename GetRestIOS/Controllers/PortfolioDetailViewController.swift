//
//  PortfolioDetailViewController.swift
//  GetRestIOS
//
//  Created by 박경선 on 04/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class PortfolioDetailTableViewController: UITableViewController {
    var portfolioDetail : PortfolioDetailModel =
        PortfolioDetailModel("동아리", "솝트", "2019.03 ~ 2019.07", ["UI디자인", "동아리"], "여행이 취미인 트리플 직원들은 어디로 가야하나 허허허허ㅓ허허ㅓㅇ여행이 취미인 트리플 직원들은 어디로 가야하나여행이 취미인 트리플 직원들은 어디로 가야하나 허허허허ㅓ허허ㅓㅇ여행이 취미인 트리플 직원들은 어디로 가야하나여행이 취미인 트리플 직원들은 어디로 가야하나 허허허허ㅓ허허ㅓㅇ여행이 취미인 트리플 직원들은 어디로 가야하나여행이 취미인 트리플 직원들은 어디로 가야하나 허허허허ㅓ허허ㅓㅇ여행이 취미인 트리플 직원들은 어디로 가야하나여행이 취미인 트리플 직원들은 어디로 가야하나 허허허허ㅓ허허ㅓㅇ여행이 취미인 트리플 직원들은 어디로 가야하나여행이 취미인 트리플 직원들은 어디로 가야하나 허허허허ㅓ허허ㅓㅇ여행이 취미인 트리플 직원들은 어디로 가야하나여행이 취미인 트리플 직원들은 어디로 가야하나 허허허허ㅓ허허ㅓㅇ여행이 취미인 트리플 직원들은 어디로 가야하나여행이 취미인 트리플 직원들은 어디로 가야하나 허허허허ㅓ허허ㅓㅇ여행이 취미인 트리플 직원들은 어디로 가야하나여행이 취미인 트리플 직원들은 어디로 가야하나 허허허허ㅓ허허ㅓㅇ여행이 취미인 트리플 직원들은 어디로 가야하나여행이 취미인 트리플 직원들은 어디로 가야하나 허허허허ㅓ허허ㅓㅇ여행이 취미인 트리플 직원들은 어디로 가야하나")
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var hashTagsCollectionView: UICollectionView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var contentView: UIView!
    
    var height: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableData()
        setCollectionView()
        height = contentTextView.contentSize.height
        setHeight()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    
//    override func viewWillA(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigationBarWithLogo"), for: .default)
//
//    }
    
    func setNavigationBar() {
        self.navigationItem.title = "기록보기"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.mainGreen]
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.tintColor = UIColor.mainGreen
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    
    func setTableData(){
        self.categoryLabel.text = portfolioDetail.portfolioCategory
        self.titleLabel.text = portfolioDetail.portfolioTitle
        self.durationLabel.text = portfolioDetail.portfolioDuration
        self.contentTextView.text = portfolioDetail.portfolioContent
        
        // 내용에 따라 테이블 셀 높이 지정  ( 40은 gap )
        contentView.frame.size.height = contentTextView.frame.height + 40
        contentTextView.isScrollEnabled = false
        contentTextView.isEditable = false
        var frame = self.contentTextView.frame
        frame.size.height = self.contentTextView.contentSize.height
        self.contentTextView.frame = frame
        
        // 테이블 뷰 크기 조정
        let tableViewImageView = UIImageView(image: UIImage(named: "portfolioTestImg"))
        tableViewImageView.contentMode = .top
        self.tableView.backgroundView = tableViewImageView
        self.tableView.estimatedRowHeight = 174
        self.tableView.rowHeight = UITableView.automaticDimension
        
        contentTextView.delegate = self
        contentTextView.translatesAutoresizingMaskIntoConstraints = true
        contentTextView.sizeToFit()
        contentTextView.isScrollEnabled = false
    }
    
    func setCollectionView(){
        let nibName = UINib(nibName: "HashTagCollectionViewCell", bundle: nil)
        self.hashTagsCollectionView.delegate = self
        self.hashTagsCollectionView.dataSource = self
        self.hashTagsCollectionView.register(nibName, forCellWithReuseIdentifier: "hashTagCell")
        let hashTagsCVFlowLayout = hashTagsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        hashTagsCVFlowLayout.estimatedItemSize = CGSize(width: 64, height: 27)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.roundCorners(corners: [.topLeft, .topRight], radius: 15)
        cell.frame.size.height = 1000
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension PortfolioDetailTableViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        contentTextView.sizeToFit()
        let gap = contentTextView.contentSize.height - height
        if (gap == 0){
            height = contentTextView.contentSize.height
            contentView.frame.size.height = contentView.frame.height + gap
            tableView.reloadData()
        }
    }
    
    func setHeight(){
        contentTextView.sizeToFit()
        contentView.frame.size.height = contentTextView.contentSize.height + 50
        tableView.reloadData()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        tableView.reloadData()
    }
}

extension PortfolioDetailTableViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return portfolioDetail.portfolioHashTags!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hashTagCell", for: indexPath) as! HashTagCollectionViewCell
        let tagString = (portfolioDetail.portfolioHashTags![indexPath.row]) + "        "
        cell.hashTagLabel?.text = tagString
        return cell
    }
}