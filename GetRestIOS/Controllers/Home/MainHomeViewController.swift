//
//  MainHomeViewController.swift
//  GetRestIOS
//
//  Created by 박경선 on 30/06/2019.
//  Copyright © 2019 최리안. All rights reserved.
//

import UIKit
import ScrollableGraphView

class MainHomeViewController: UIViewController {
    var graphDetailList : [HomeGraphDetailModel] = []
    var homeGraphData: [HomeGraphModel] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topSideView: UIImageView!
    @IBOutlet weak var topSideLabel: UILabel!
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var graphDetailTableView: UITableView!
    @IBOutlet weak var firstSectionView: UIView!
    @IBOutlet weak var secondSectionView: UIView!
    @IBOutlet weak var quarterDate: UILabel!
    
    var scrollViewContentHeight = 1200 as CGFloat
    let navigationBarHeight = 64 as CGFloat
    var tableCellHeight = 64 as CGFloat
    var tableHeight = 1000 as CGFloat
    var date: String = ""
    
    var username: String = "박경선"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackgroudGray
        setTableView()
        setTopSideView()
        let attributedString = NSMutableAttributedString()
            .bold(username, fontSize: 23)
            .normal("님의 \n기록을 살펴 볼까요?", fontSize: 23)
        topSideLabel.attributedText = attributedString
        firstSectionView.dropShadow(color: UIColor.shadow, offSet: CGSize.zero, opacity: 1.0, radius: 5)
        secondSectionView.dropShadow(color: UIColor.shadow, offSet: CGSize.zero, opacity: 1.0, radius: 5)
        
    }
    
    func setTableView() {
        self.graphDetailTableView.delegate = self
        self.graphDetailTableView.dataSource = self
        self.graphDetailTableView.backgroundColor = UIColor.white
        self.graphDetailTableView.separatorColor = UIColor.mainBackgroudGray
        self.graphDetailTableView.alwaysBounceVertical = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setNavigationBar()
        getGraphData()
        graphDetailTableView.reloadData()
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor.mainGreen
        // 불투명하게 만들기
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigationBarWithLogo"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    func setTopSideView(){
        topSideView.backgroundColor = UIColor(patternImage: UIImage(named: "homeTopSideViewImg")!)
        topSideView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 28)
        topSideLabel.numberOfLines = 0
    }
    
    func setDetailTableView(){
        print("quarterDate.text  : ", quarterDate.text! )
        HomeMainService.shared.getDetailTableData(date: quarterDate.text!){
            [weak self]
            data in
            guard let `self` = self else { return }
            switch data {
            case .success(let detailList):
                self.graphDetailList = detailList as! [HomeGraphDetailModel]
                self.graphDetailTableView.reloadData()
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
                self.alertTimerController(message: "통신 실패 - 네트워크 상태를 확인하세요.", timer: 2)
                break
            }
        }
    }
    
    func getGraphData() {
        HomeMainService.shared.getGraphData() {
            [weak self]
            data in
            guard let `self` = self else { return }
            switch data {
            case .success(let res):
                self.homeGraphData = res as! [HomeGraphModel]
                self.setGraph(containerView: self.graphView)
                let length = self.homeGraphData.count
                self.quarterDate.text = self.homeGraphData[length-1].date
//                self.setDetailTableView()
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
                self.alertTimerController(message: "통신 실패 - 네트워크 상태를 확인하세요.", timer: 2)
                break
            }
        }
    }
}

extension MainHomeViewController : ScrollableGraphViewDataSource {
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        return Double(homeGraphData[pointIndex].count)
    }
    
    func label(atIndex pointIndex: Int) -> String {
        let dateLabel = homeGraphData[pointIndex].date
        //        if dateLabel != "" {
        //            quarterDate.text = "\(dateLabel)분기"
        //        }
        return "\(dateLabel)"
    }
    
    func numberOfPoints() -> Int {
        return homeGraphData.count
    }
    
    func setGraph(containerView: UIView)  {
        let frame : CGRect = CGRect(x: 0,
                                    y: 0,
                                    width: self.graphView.frame.width,
                                    height: self.graphView.frame.height)
        let barGraphView = ScrollableGraphView(frame: frame, dataSource: self)
        let barPlot = BarPlot(identifier: "bar")
        
        barPlot.barWidth = 12
        barPlot.barLineWidth = 0
        barPlot.barColor = UIColor.graphBarGray
        
        //        barPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        //        barPlot.animationDuration = 1.5
        barGraphView.topMargin = 0
        barGraphView.bottomMargin = 16
        barGraphView.dataPointSpacing = setSpacing()
        barGraphView.isScrollEnabled = false
        
        barGraphView.leftmostPointPadding = 20
        let referenceLines = ReferenceLines()
        
        //        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 7)
        referenceLines.dataPointLabelFont = UIFont.systemFont(ofSize: 14)
        referenceLines.referenceLineColor = UIColor.graphLineGray
        referenceLines.referenceLineLabelColor = UIColor.mainColorBlue
        referenceLines.dataPointLabelColor = UIColor.mainColorBlue
        //        referenceLines.shouldShowReferenceLines = false
        referenceLines.shouldAddLabelsToIntermediateReferenceLines = false
        referenceLines.shouldAddUnitsToIntermediateReferenceLineLabels = false
        
        barGraphView.backgroundFillColor = UIColor.graphBackgroundWhite
        //        barGraphView.shouldAnimateOnStartup = false
        
        //        barGraphView.rangeMax = graphDetailList.count.max()!
        barGraphView.rangeMax = 5
        barGraphView.rangeMin = 0
        
        barGraphView.addReferenceLines(referenceLines: referenceLines)
        barGraphView.addPlot(plot: barPlot)
        
        containerView.addSubview(barGraphView)
    }
    
    func setSpacing() -> CGFloat {
        let graphViewWidth = graphView.frame.width
        let barWidth: CGFloat = 12.0
        let emptyWidth = graphViewWidth - barWidth * CGFloat(homeGraphData.count )
        let space = emptyWidth / CGFloat( homeGraphData.count )
        return space + barWidth
    }
}


extension MainHomeViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return graphDetailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "graphDetailTableViewCell") as! HomeGraphDetailTableViewCell
        cell.contentView.backgroundColor = UIColor.white
        let detailObject = graphDetailList[indexPath.row]
        cell.portfolioTitle?.text = detailObject.portfolioTitle
        cell.portfolioDuration?.text = "\(detailObject.portfolioStartDate) ~ \(detailObject.portfolioExpireDate)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dvc = self.storyboard!.instantiateViewController(withIdentifier: "homeDetailView")
        self.navigationController?.pushViewController(dvc, animated: true)
        
    }
}

extension NSMutableAttributedString {
    
    func bold(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: fontSize)]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
    }
    
    func normal(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: fontSize)]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
    }
    
    func color(_ text: String, color: UIColor, fontSize: CGFloat) -> NSMutableAttributedString {
        var attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: fontSize)]
        attrs[.foregroundColor] = color
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
    }
}



