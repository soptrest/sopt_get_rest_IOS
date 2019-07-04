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
    var barPlotData: [Double] = [ 2, 4, 3, 6, 3, 7, 3, 4, 3, 2, 1, 4]
    var xAxisLabels: [String] = ["1" ,"2","3", "4", "1" ,"2","3", "4", "1" ,"2","3", "4",]
    var graphDetailList : [HomeGraphDetailModel] = [
        HomeGraphDetailModel("솝트", "2019.03 ~ 2019.07"),
        HomeGraphDetailModel("매디", "2018.01 ~ 2019.12"),
        HomeGraphDetailModel("매디", "2018.01 ~ 2019.12"),
        HomeGraphDetailModel("매디", "2018.01 ~ 2019.12"),
        HomeGraphDetailModel("매디", "2018.01 ~ 2019.12")
    ]
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topSideView: UIImageView!
    @IBOutlet weak var topSideLabel: UILabel!
    @IBOutlet weak var graphView: UIView!
    @IBOutlet weak var graphDetailTableView: UITableView!
    
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
        setNavigationBar()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
    
    func setTableView() {
        let indexCount = self.graphDetailList.count + 1
        let cardViewGap: CGFloat = 10
        
        self.tableHeight = (tableCellHeight * CGFloat(indexCount)) + ((cardViewGap) * CGFloat(indexCount))
        self.graphDetailTableView.frame.size.height = tableHeight
        self.graphDetailTableView.delegate = self
        self.graphDetailTableView.dataSource = self
//        self.graphDetailTableView.estimatedRowHeight = tableCellHeight
//        self.graphDetailTableView.rowHeight = UITableView.automaticDimension
        self.graphDetailTableView.backgroundColor = UIColor.white
        self.graphDetailTableView.separatorColor = UIColor.mainBackgroudGray
        self.graphDetailTableView.alwaysBounceVertical = false
        self.graphDetailTableView.isScrollEnabled = false
        
        updateScrollView()
    }
    
    func updateScrollView(){
        let scrollViewContentWidth = view.frame.width as CGFloat
        let tabBarHeight: CGFloat = 49
        let upperHeight: CGFloat = topSideView.frame.height + 22 + graphView.frame.height
        let lowerHeight: CGFloat = 55 + tableHeight + tabBarHeight
        scrollViewContentHeight = upperHeight + lowerHeight + 5
        scrollView.contentSize = CGSize(width: scrollViewContentWidth, height: scrollViewContentHeight)
        scrollView.bounces = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setGraph(containerView: graphView)
        graphDetailTableView.reloadData()
    }
    
    func setNavigationBar(){
//        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBarHeight)
        navigationController?.navigationBar.barTintColor = UIColor.mainGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigationBarWithLogo"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setTopSideView(){
        topSideView.backgroundColor = UIColor(patternImage: UIImage(named: "homeTopSideViewImg")!)
        topSideView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 28)
        
        topSideLabel.text = "\(username)님의\n기록을 살펴볼까요?"
        topSideLabel.numberOfLines = 0
    }
    
    func attributedText(withString string: String, boldString: String, font: UIFont) -> String {
        let attributedString = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString.string
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
        drawReferenceLine(containerView)
        let frame : CGRect = CGRect(x: 0,
                                    y: 0,
                                    width: self.graphView.frame.width,
                                    height: self.graphView.frame.height)
        let barGraphView = ScrollableGraphView(frame: frame, dataSource: self)
        let barPlot = BarPlot(identifier: "bar")
        
        barPlot.barWidth = 10
        barPlot.barLineWidth = 0
        barPlot.barColor = UIColor.mainColorGreen
        
//        barPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
//        barPlot.animationDuration = 1.5
        barGraphView.topMargin = 16
        barGraphView.bottomMargin = 26
        barGraphView.dataPointSpacing = 27
        
        barGraphView.leftmostPointPadding = 20
        let referenceLines = ReferenceLines()
        
//        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 7)
        referenceLines.dataPointLabelFont = UIFont.boldSystemFont(ofSize: 14)
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
        containerView.roundCorners(corners: [.allCorners], radius: 5)
        containerView.dropShadow(color: UIColor.shadow, offSet: CGSize.zero, opacity: 1.0, radius: 5)
    }
    
    func drawReferenceLine(_ containerView: UIView){
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



