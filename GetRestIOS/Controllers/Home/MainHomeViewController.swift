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
    var barPlotData: [Double] = [ 7, 4, 7, 6, 3, 7, 3, 4, 3, 2, 7, 4]
    var xAxisLabels: [String] = ["1" ,"2","3", "4", "1" ,"2","3", "4", "1" ,"2","3", "4",]
    var graphDetailList : [HomeGraphDetailModel] = []
//        HomeGraphDetailModel("솝트", "2019.03", "2019.07"),
//        HomeGraphDetailModel("매디", "2018.01", "2019.12"),
//        HomeGraphDetailModel("매디", "2018.01", "2019.12"),
//        HomeGraphDetailModel("매디", "2018.01", "2019.12"),
//        HomeGraphDetailModel("매디", "2018.01", "2019.12")
//    ]
    var homeGraphData: [HomeGraphModel] = []
    let jwt: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjozMSwidXNlckVtYWlsIjoiMDcxMUBuYXZlci5jb20iLCJpYXQiOjE1NjI4MzA4ODgsImV4cCI6MTU2MjkxNzI4OCwiaXNzIjoic2FuZ3l1bkxFRSJ9.xWjmBLrADRLggowhsa-dvfneuEnGLjdaUTl5bga9TYM"
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topSideView: UIImageView!
    @IBOutlet weak var topSideLabel: UILabel!
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var graphDetailTableView: UITableView!
    @IBOutlet weak var firstSectionView: UIView!
    @IBOutlet weak var secondSectionView: UIView!
    
    
    var scrollViewContentHeight = 1200 as CGFloat
    let navigationBarHeight = 64 as CGFloat
    var tableCellHeight = 64 as CGFloat
    var tableHeight = 1000 as CGFloat
    
    var username: String = "박경선"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("homeGraphData  :  " , homeGraphData)
        view.backgroundColor = UIColor.mainBackgroudGray
        setTableView()
        setTopSideView()
        getGraphData()
//        setGraph(containerView: graphView)
        graphDetailTableView.reloadData()
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
        graphDetailTableView.reloadData()
//        tableView.deselectRow(at: indexPath, animated: true)
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
    
    func getGrapghDetailTable(){
        
    }
    
    func getGraphData() {
        HomeMainService.shared.getGraphData(authorization: jwt) {
            [weak self]
            data in
            
            guard let `self` = self else { return }
            switch data {
            case .success(let res):
                self.homeGraphData = res as! [HomeGraphModel]
                self.setGraph(containerView: self.graphView)
                break
            case .requestErr(let err):
                print(".requestErr(\(err))")
                break
            case .pathErr:
                // 대체로 경로를 잘못 쓴 경우입니다.
                // 오타를 확인해보세요.
                print("경로 에러")
                break
            case .serverErr:
                // 서버의 문제인 경우입니다.
                // 여기에서 동작할 행동을 정의해주시면 됩니다.
                print("서버 에러")
                break
            case .networkFail:
//                self.simpleAlert(title: "통신 실패", message: "네트워크 상태를 확인하세요.")
                break
            }
        }
    }
}

extension MainHomeViewController : ScrollableGraphViewDataSource {
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        return Double(homeGraphData[pointIndex].count!)
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return homeGraphData[pointIndex].date!
    }
    
    func numberOfPoints() -> Int {
        return xAxisLabels.count
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
        barGraphView.dataPointSpacing = 27
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
        barGraphView.shouldAnimateOnStartup = false
        
        barGraphView.rangeMax = barPlotData.max()!
        barGraphView.rangeMin = 0
        
        barGraphView.addReferenceLines(referenceLines: referenceLines)
        barGraphView.addPlot(plot: barPlot)
        
        containerView.addSubview(barGraphView)
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
//        cell.portfolioTitle?.text = graphDetailList[indexPath.row].portfolioTitle!
//        cell.portfolioDuration?.text = graphDetailList[indexPath.row].portfolioDuration!
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



