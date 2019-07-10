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
        setGraph(containerView: graphView)
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
//        self.graphDetailTableView.estimatedRowHeight = tableCellHeight
//        self.graphDetailTableView.rowHeight = UITableView.automaticDimension
        self.graphDetailTableView.backgroundColor = UIColor.white
        self.graphDetailTableView.separatorColor = UIColor.mainBackgroudGray
        self.graphDetailTableView.alwaysBounceVertical = false
//        self.graphDetailTableView.isScrollEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigationBar()
    }
    func setNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor.mainGreen
        // 불투명하게 만들기
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
        
        barPlot.barWidth = 12
        barPlot.barLineWidth = 0
        barPlot.barColor = UIColor.graphBarGray
        
//        barPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
//        barPlot.animationDuration = 1.5
        barGraphView.topMargin = 0
        barGraphView.bottomMargin = 16
        barGraphView.dataPointSpacing = 27
        
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
}


