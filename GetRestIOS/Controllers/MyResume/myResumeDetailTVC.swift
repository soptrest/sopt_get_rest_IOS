//
//  myResumeDetailTVC.swift
//  GetRestIOS
//
//  Created by 박경선 on 10/07/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit

class myResumeDetailTVC: UITableViewController {
    
    // section View
    @IBOutlet weak var questionSection: UIView!
    @IBOutlet weak var answerSection: UIView!
    
    // 질문 섹션 레이블
    @IBOutlet weak var questionNumLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var answerContent: UITextView!
    @IBOutlet weak var countingLabel: UILabel!
    
    
    // "수정중" 뷰와 레이블
    @IBOutlet weak var editingContainerView: UIView!
    @IBOutlet weak var editingLabel: UILabel!
    
    // 문항 넘기기 버튼
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var leftBottomBtn: UIButton!
    @IBOutlet weak var rightBottomBtn: UIButton!
    
    
    var countQuestionNum: Int = 1
    var maxContent: Int = 600
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = data.jobType
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.mainGreen]
        setCountLabel()
        countQuestionNum = 1
        questionLabel.numberOfLines = 0
        setData(title: data.jobTitle, form: data.jobType, content: data.content)
        answerContent.isEditable = false
        editingContainerView.roundCorners(corners: [.allCorners], radius: 13)
        editingLabel.text = ""
        answerContent.delegate = self
        answerContent.translatesAutoresizingMaskIntoConstraints = true
        answerContent.sizeToFit()
        answerContent.isScrollEnabled = false
        
        self.tableView.estimatedRowHeight = answerContent.contentSize.height + 200
        self.tableView.rowHeight = UITableView.automaticDimension
        
        height = answerContent.contentSize.height

        answerSection.frame.size.height = answerContent.contentSize.height + 200
        navigationController?.navigationBar.tintColor = UIColor.mainGreen
        let edit = UIBarButtonItem(image: UIImage(named: "icMyResumeEdit"), style: .plain, target: self, action: #selector(textEdit))
        navigationItem.rightBarButtonItems = [edit]
    }
    
    @objc func textEdit(){
        let save = UIBarButtonItem(image: UIImage(named: "icMyResumeSave"), style: .plain, target: self, action: #selector(textSave))
        let done = UIBarButtonItem(image: UIImage(named: "btnDone"), style: .plain, target: self, action: #selector(editDone))
        navigationItem.rightBarButtonItems = [done, save]
        
        answerContent.isEditable = true
        questionSection.backgroundColor = UIColor(red: 226.0/255.0, green: 239.0/255.0, blue:  219.0/255.0, alpha: 1.0)
        editingLabel.text = "수정중"
    }
    
    func setData(title: String, form: String, content: String){
        questionNumLabel.text = "문항\(countQuestionNum)"
        numLabel.text = String(countQuestionNum)
        questionLabel.text = title
        jobTitleLabel.text = form
        answerContent.text = content
    }
    
    @objc func textSave(){}
    
    @objc func editDone(){
        let edit = UIBarButtonItem(image: UIImage(named: "icMyResumeEdit"), style: .plain, target: self, action: #selector(textEdit))
        navigationItem.rightBarButtonItems = [edit]
        
        answerContent.isEditable = false
        editingLabel.text = ""
        questionSection.backgroundColor = UIColor.white
    }
    func setHeight(){
        answerContent.sizeToFit()
        answerSection.frame.size.height = answerContent.contentSize.height + 200
        tableView.reloadData()
    }
    
    @IBAction func leftButtonAction(_ sender: UIButton) {
        countQuestionNum = countQuestionNum - 1
        setData(title: "btnResumeLeft", form: "btnResumeLeft", content: "btnResumeLeft")
        if countQuestionNum == 1 {
            leftBtn.setImage(UIImage(named: "btnResumeLeft"), for: .normal)
            leftBottomBtn.setImage(UIImage(named: "btnResumeLeft"), for: .normal)
            leftBtn.isEnabled = false
            leftBottomBtn.isEnabled = false
        } else if countQuestionNum == 4 {
            rightBtn.setImage(UIImage(named: "btnResumeRightActive"), for: .normal)
            rightBottomBtn.setImage(UIImage(named: "btnResumeRightActive"), for: .normal)
            rightBtn.isEnabled = true
            rightBottomBtn.isEnabled = true
        }
        setHeight()
    }
    
    @IBAction func rightButtonAction(_ sender: UIButton) {
        countQuestionNum = countQuestionNum + 1
        setData(title: "btnResumeLeft", form: "btnResumeRight", content: "btnResumeLeft")
        if countQuestionNum == 5 {
            rightBtn.setImage(UIImage(named: "btnResumeRight"), for: .normal)
            rightBottomBtn.setImage(UIImage(named: "btnResumeRight"), for: .normal)
            rightBtn.isEnabled = false
            rightBottomBtn.isEnabled = false
        } else if countQuestionNum == 2 {
            leftBtn.setImage(UIImage(named: "btnResumeLeftActive"), for: .normal)
            leftBottomBtn.setImage(UIImage(named: "btnResumeLeftActive"), for: .normal)
            leftBtn.isEnabled = true
            leftBottomBtn.isEnabled = true
        }
        setHeight()
    }
    
    func setCountLabel(){
        var color: UIColor
        if maxContent < answerContent.text.count {
            color = UIColor.red
        } else {
            color = UIColor.mainGreen
        }
        countingLabel.attributedText = NSMutableAttributedString()
            .normal("\(maxContent)자/", fontSize: 13)
            .color("\(answerContent.text.count)자", color: color, fontSize: 13)
    }
    
    
    let data: MyResumeDetailModel = MyResumeDetailModel(
        "내가 생각하는 최고의 서비스디자인이란 무엇인가? (최대 600자)",
        "네이버/다음 온라인마케팅 영업및관리...",
        "기사(騎士)는 중세부터 유럽에서 기마로 싸우는 전사에게 주는 명예 칭호 및 그로부터 파생한 계급을 가리킨다. 기사는 분류상 귀족이지만 귀족 중에는 최하급 귀족에 속하며 준귀족적인 성격을 띈다. 우리가 흔히 부르는 귀족은 기사보다 상위의 귀족을 의미한다. 오늘날에는 명예 칭호로 쓰이고 있다(이외의 기마부대에 대해서는 기병 항목을 참조하라). 기사는 하급 귀족이자 준귀족적인 계급이며 평민이 기사가 되는 일도 있었다. 기사는 기사가 되려면 7살부터 기사 훈련을 받아야 하며 14살이 되면 무기를 옮기거나 하는 심부름을 받게 된다. 21살이 되면 기사직위를 얻는데 칼로 어깨와 머리 위를 한번씩 대는 것이 기사가 되는 의식이다. 그러나 총과 대포가 등장하게 되면서 기사는 몰락했다. 중세에 활동한 초기 기사들은 직업적인 기마전사들로서 일부는 영주에게서 봉토(封土)를 받고 군역(軍役)의무를 제공하던 봉신들이었으며 봉토를 받지 못한 기사들도 있었다. 기사들은 모두 자유민이었으나 항상 자유민만이 기사가 될 수 있었던 것은 아니었다. 기사제도가 가장 성행했던 11~12세기에는 봉토수여는 기사작위를 받는 것과 꼭 관련있는 것은 아니었다(→ 기사의 봉사). Nyle Malik 기사들은 주로 황제 또는 공작, 인판테, 후작, 변경백, 백작, 자작, 남작, 준남작 등 고위 귀족들에게 충성을 다했다. 그 예로 연회장이나 파티장, 백작의 집 등을 지키는 일 등이 있었다.")
    var height: CGFloat = 0.0
}

extension myResumeDetailTVC : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        setCountLabel()
        answerContent.sizeToFit()
        let gap = answerContent.contentSize.height - height
        if (gap > 60) || (gap < -60){
            height = answerContent.contentSize.height
            answerSection.frame.size.height = answerSection.frame.size.height + gap
            tableView.reloadData()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        tableView.reloadData()
    }
}
