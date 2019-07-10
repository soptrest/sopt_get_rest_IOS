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
    var graphDetailList : [HomeGraphDetailModel] = [
        HomeGraphDetailModel("솝트", "2019.03 ~ 2019.07"),
        HomeGraphDetailModel("문화교류 연합동아리 매디", "2018.01 ~ 2019.12"),
        HomeGraphDetailModel("삼성전자 나눔 봉사단", "2018.01 ~ 2019.12"),
        HomeGraphDetailModel("멋쟁이 사자처럼", "2018.01 ~ 2019.12")
    ]
    
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
        view.backgroundColor = UIColor.mainBackgroudGray
        setTableView()
        setTopSideView()
        graphDetailTableView.reloadData()
        let attributedString = NSMutableAttributedString()
            .bold(username, fontSize: 23)
            .normal("님의 \n기록을 살펴 볼까요?", fontSize: 23)
        topSideLabel.attributedText = attributedString
        firstSectionView.dropShadow(color: UIColor.shadow, offSet: CGSize.zero, opacity: 1.0, radius: 5)
        secondSectionView.dropShadow(color: UIColor.shadow, offSet: CGSize.zero, opacity: 1.0, radius: 5)
//        graphView.addGestureRecognizer(<#T##gestureRecognizer: UIGestureRecognizer##UIGestureRecognizer#>)
    }
    
    func setTableView() {
        self.graphDetailTableView.delegate = self
        self.graphDetailTableView.dataSource = self
        //        self.graphDetailTableView.estimatedRowHeight = tableCellHeight
        //        self.graphDetailTableView.rowHeight = UITableView.automaticDimension
        self.graphDetailTableView.backgroundColor = UIColor.white
        self.graphDetailTableView.separatorColor = UIColor.mainBackgroudGray
        self.graphDetailTableView.alwaysBounceVertical = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigationBar()
        setGraph(containerView: graphView)
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor.mainGreen
        // 불투명하게 만들기
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(
            UIImage(named: "navigationBarWithLogo"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setTopSideView(){
        topSideView.backgroundColor = UIColor(patternImage: UIImage(named: "homeTopSideViewImg")!)
        topSideView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 28)
        topSideLabel.text = "\(username)님의\n기록을 살펴볼까요?"
        topSideLabel.numberOfLines = 0
    }
}

extension MainHomeViewController : ScrollableGraphViewDataSource {
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        return barPlotData[pointIndex]
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return xAxisLabels[pointIndex]
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
        barGraphView.topMargin = 0
        barGraphView.bottomMargin = 16
        barGraphView.isScrollEnabled = false
        barGraphView.leftmostPointPadding = 0 + ( barPlot.barWidth / 2 )
        barGraphView.dataPointSpacing = caculateDataPointSpacing(frameWidth: frame.width,
                                                                 count: barPlotData.count,
                                                                 barWidth: barPlot.barWidth)
        barGraphView.backgroundFillColor = UIColor(white: 1.0, alpha: 0.0)
        
        barPlot.barColor = UIColor.graphBarGray
        let referenceLines = ReferenceLines()
        
        referenceLines.dataPointLabelFont = UIFont.systemFont(ofSize: 14)
        referenceLines.referenceLineColor = UIColor.graphLineGray
        referenceLines.referenceLineLabelColor = UIColor.ticksDarkGray
        referenceLines.dataPointLabelColor = UIColor.ticksDarkGray
        referenceLines.shouldAddLabelsToIntermediateReferenceLines = false
        referenceLines.shouldAddUnitsToIntermediateReferenceLineLabels = false
        
        barGraphView.rangeMax = barPlotData.max()!
        barGraphView.rangeMin = 0
        
        barGraphView.addPlot(plot: barPlot)
        barGraphView.addReferenceLines(referenceLines: referenceLines)
        containerView.addSubview(barGraphView)
        
    }
    
    func caculateDataPointSpacing(frameWidth: CGFloat, count: Int, barWidth: CGFloat) -> CGFloat {
        let barTotalWidth: CGFloat =  barWidth * CGFloat( count )
        let dataSpacing = ( frameWidth - barTotalWidth ) / CGFloat( count - 1 )
        return dataSpacing + barWidth
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
        cell.portfolioTitle?.text = graphDetailList[indexPath.row].portfolioTitle!
        cell.portfolioDuration?.text = graphDetailList[indexPath.row].portfolioDuration!
        return cell
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


