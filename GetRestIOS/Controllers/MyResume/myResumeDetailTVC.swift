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
    
    var myResumeIdx: Int = 1
    var countQuestionNum: Int = 1
    var maxContent: Int = 600
    
    var data: MyResumeDetailModel!
    var height: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        self.navigationItem.title = data.recruitJobType
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.mainGreen]
        setCountLabel()
        countQuestionNum = 1
        questionLabel.numberOfLines = 0
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
        loadData()
        setCountLabel()
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
        loadData()
        setCountLabel()
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
    
    func loadData(){
        self.data = dataList[countQuestionNum-1]
        setData(title: data.questionTitle, form: data.recruitJobType, content: data.resumeContent)
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
        answerContent.sizeToFit()
        let gap = answerContent.contentSize.height - height
        if (gap > 60) || (gap < -60){
            height = answerContent.contentSize.height
            answerSection.frame.size.height = answerSection.frame.size.height + gap
            tableView.reloadData()
        }
    }
    
    let dataList: [MyResumeDetailModel] = [
        MyResumeDetailModel(1, "내가 생각하는 최고의 서비스디자인이란 무엇인가? (최대 600자)", "네이버/다음 온라인마케팅 영업및관리...", "꿈을 위해 새로운 분야를 ‘도전’하며 저만의 커리어를 만들어왔습니다. 대학 2학년 때 신호와 소음이라는 책을 읽으며 미래를 엿보는 빅데이터 분석에 큰 관심을 가졌습니다. 저는 빅데이터 분석의 핵심 근간은 방대한 데이터의 저장과 처리를 위한 플랫폼 구축이라 생각하여, 데이터 엔지니어의 꿈을 키웠습니다. 이를 위해 IT라는 새로운 분야를 시작하기 위해 Java&빅데이터 개발자 양성 과정에 도전했습니다. 먼저 Java를 능숙하게 다루는 것을 목표로 세웠습니다. 처음 접하는 Java API는 코드 리팩토링으로 확실히 알고 넘어가고자 노력하여 지뢰 찾기, 멀티채팅 등의 프로그램을 구현했습니다. 나아가 ‘학원관리 프로그램’ Java GUI 프로젝트와 ‘사회인 야구단 웹사이트’ MVC2 프로젝트를 완성하며 Java 및 여러 웹 개발 언어와 Oracle DB 구축, spring framework 개발 능력을 갖출 수 있었습니다. 교육 수료 후, 빅데이터 저장과 처리에 큰 관심을 가졌고 곧바로 Hadoop 공부를 시작했습니다. CentOS 기반의 Linux 환경에서 MapReduce와 Pig, Hive, Hbase를 익혔고 서울시 버스 승하차, 미국 항공데이터 등 방대한 데이터를 분석하며 관심을 키워갔습니다. 배운 지식을 바탕으로 AWS EC2를 사용한 Hadoop 클러스터를 구축했고 현재 EMR 기반의 Spark MLlib 프로젝트를 진행하며 Scala를 익히고 있습니다. 목표를 세우고 끊임없이 도전하는 제 강점을 발휘하여 분산과 병렬 처리 아키텍처의 전문성을 확보한 데이터 엔지니어로 성장하고 싶습니다"),
        MyResumeDetailModel(2, "성장과정을 기반으로 자신의 가치관에 대해 서술해 주십시오. ","네이버/다음 온라인마케팅 영업및관리..." , "고객 맞춤형 서비스에 도전하는 정신을 발휘하는 우아한 형제들에서 저의 능력을 발휘하고자 지원했습니다. O2O서비스와 Untact 마케팅을 결합한 혁신의 아이콘입니다. 온라인에서 오프라인으로 연결되는 O2O서비스와 조용한 소비의 확산인 Untact 마케팅이 결합체가 바로 배달의 민족입니다. 이를 통해 고객은 더욱더 간편하고 손쉽게 소비를 할 수 있습니다. 고객 맞춤형 서비스의 도입을 통해 시장의 판도를 바꾼 도전 정신을 볼 수 있습니다. 이러한 우아한 형제들에서 저의 능력을 발휘하고자 지원했습니다.영업 직무에 있어서 저의 경쟁력은 다음과 같습니다.1. 실무 영업 경험을 가지고 있습니다. OOOOO에서 5개월간 영업 사원으로 근무하며 실무 영업 경험을 가지고 있습니다. 신규 영업 계획 수립, Pipe-Line 관리, 실적 Feedback을 통한 영업 전략 재수립을 했습니다. 광진구 중랑구 영업 담당자로서 서비스 소개, 영업 활동 계획 수립, 지역 상권 분석 활동을 했습니다. "),
        MyResumeDetailModel(3, "지원동기를 서술해 주십시오.","네이버/다음 온라인마케팅 영업및관리...","꿈을 위해 새로운 분야를 ‘도전’하며 저만의 커리어를 만들어왔습니다. 대학 2학년 때 신호와 소음이라는 책을 읽으며 미래를 엿보는 빅데이터 분석에 큰 관심을 가졌습니다. 저는 빅데이터 분석의 핵심 근간은 방대한 데이터의 저장과 처리를 위한 플랫폼 구축이라 생각하여, 데이터 엔지니어의 꿈을 키웠습니다. 이를 위해 IT라는 새로운 분야를 시작하기 위해 Java&빅데이터 개발자 양성 과정에 도전했습니다. 먼저 Java를 능숙하게 다루는 것을 목표로 세웠습니다. 처음 접하는 Java API는 코드 리팩토링으로 확실히 알고 넘어가고자 노력하여 지뢰 찾기, 멀티채팅 등의 프로그램을 구현했습니다. 나아가 ‘학원관리 프로그램’ Java GUI 프로젝트와 ‘사회인 야구단 웹사이트’ MVC2 프로젝트를 완성하며 Java 및 여러 웹 개발 언어와 Oracle DB 구축, spring framework 개발 능력을 갖출 수 있었습니다. 교육 수료 후, 빅데이터 저장과 처리에 큰 관심을 가졌고 곧바로 Hadoop 공부를 시작했습니다. CentOS 기반의 Linux 환경에서 MapReduce와 Pig, Hive, Hbase를 익혔고 서울시 버스 승하차, 미국 항공데이터 등 방대한 데이터를 분석하며 관심을 키워갔습니다. 배운 지식을 바탕으로 AWS EC2를 사용한 Hadoop 클러스터를 구축했고 현재 EMR 기반의 Spark MLlib 프로젝트를 진행하며 Scala를 익히고 있습니다. 목표를 세우고 끊임없이 도전하는 제 강점을 발휘하여 분산과 병렬 처리 아키텍처의 전문성을 확보한 데이터 엔지니어로 성장하고 싶습니다"),
        MyResumeDetailModel(4, "공동의 목표 달성을 위한 협업 경험을 본인이 수행한 역할 중심으로 제시하십시오","네이버/다음 온라인마케팅 영업및관리...", "기숙학원에서 약 3년 가까이 수학 멘토를 하며 담당 학생 모두를 희망하는 대학에 진학시키는 목표를 세워 실행해 본 경험이 있습니다. 1년간 근무를 하면서 두 가지 문제점을 발견했습니다. 먼저 학생들의 부족한 학습 동기였습니다. 효율적인 학습법을 알지 못해 부진한 성적이 원인이었습니다. 또한 개인별 수준을 고려하지 않고 채점과 첨삭만 진행했던 비효율적인 수업 방식이었습니다. 저는 올바른 학습법과 맞춤형 수업이 도움이 될 것이라는 생각했습니다. 그래서 시스템의 개선을 통해 ‘이전보다 더 많은 학생들이 원하는 대학에 진학할 수 있도록 하자’는 목표를 세웠습니다. 이를 위해 원장님께 개선 방향을 제시했습니다. 먼저 올바른 학습법을 가르쳐주기 위해 문제를 풀어주는데 그치지 않고 '왜'를 항상 설명하며 논리적인 연결 관계를 강조했습니다. 또한 유형별 풀이를 손수 만들어 쉽게 응용할 수 있도록 도왔습니다. 다음으로 보충수업이 필요한 학생들과 단순 풀이첨삭을 원하는 학생들로 분류하는 맞춤형 방식을 제안했습니다. 원장님도 흔쾌히 수락하시며 학생들의 관리 권한을 모두 위임해주셨습니다. 그 결과 맡은 수험생 8명 중 6명의 성적이 10점 이상 올랐고 2단계 향상된 등급을 받았습니다. 아쉽게도 모두가 원하는 대학에 진학하는 드라마틱한 결과는 이루지 못했지만 각자 뚜렷한 진로를 정하며 학습 동기를 가질 수 있었습니다. "),
        MyResumeDetailModel(5,"지원 분야와 관련하여 특정 영역의 전문성을 키우기 위해 꾸준히 노력한 경험에 대해 주십시오","네이버/다음 온라인마케팅 영업및관리...", "팀원과의 ‘활발한 소통’을 통해 서울시 일일 강수 예측 프로젝트를 성공적으로 마친 경험이 있습니다. Hadoop 클러스터 설치에 필요한 디스크 용량을 확보하기 위해 팀원과 끊임없는 소통으로 VMware를 사용하는 기존의 방식에서 벗어나 가상으로 용량을 대여하는 AWS를 떠올릴 수 있었습니다. 함께 학술 자료를 모아 메뉴얼로 만들어 EC2를 익혔고 보안그룹과 IP 설정, putty 접속에서 에러가 발생할 때마다 ‘왜’를 항상 찾으며 해결방안을 모색했습니다. 마침내 충분한 용량을 할당하여 클러스터를 구축하며 목표한 기능을 모두 완성할 수 있었습니다. 이를 통해 두 가지 결실을 거두었습니다. 먼저 혼자가 아닌 다수의 생각이 모일 때 새로운 인사이트를 창출할 수 있다는 것을 배웠습니다. 기존 방식의 한계에 대한 의견을 공유하여 AWS를 떠올렸습니다. 또한 EC2라는 새로운 환경을 도입하며 소통의 중요성을 체감했습니다. 서로 잘 알고 있는 부분을 활발히 물어보고 조언을 주고받으며 발생한 에러들을 빠르게 찾아 고칠 수 있었습니다." )
    ]
}

extension myResumeDetailTVC : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        setCountLabel()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        tableView.reloadData()
    }
}
