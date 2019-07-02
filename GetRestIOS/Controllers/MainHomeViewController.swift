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
    //    var xAxisLabels: [String] = ["1분기" ,"2분기","3분기", "4분기", "1분기" ,"2분기","3분기", "4분기", "1분기" ,"2분기","3분기", "4분기",]
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
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var graphDetailTableView: UITableView!
    
    let navigationBarHeight = 44 as CGFloat
    var username: String = "박경선"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainBackgroudGray
        
        let scrollViewContentWidth = view.frame.width as CGFloat
//        let scrollViewContentHeight = tableView.frame.height + topSideView.frame.height + graphView.frame.height + navigationBarHeight + 44 as CGFloat
        let scrollViewContentHeight = 1200 as CGFloat
        scrollView.bounces = false
        scrollView.contentSize = CGSize(width: scrollViewContentWidth, height: scrollViewContentHeight)
        
        self.graphDetailTableView.delegate = self
        self.graphDetailTableView.dataSource = self
        self.graphDetailTableView.estimatedRowHeight = 94
        self.graphDetailTableView.rowHeight = UITableView.automaticDimension
        self.graphDetailTableView.backgroundColor = UIColor.clear
        self.graphDetailTableView.separatorColor = UIColor.mainBackgroudGray
        self.graphDetailTableView.alwaysBounceVertical = false;
//        self.graphDetailTableView.register(HomeGraphDetailTableViewCell.self,  forCellReuseIdentifier: "graphDetailTableViewCell")
        
        setNavigationBar()
        setTopSideView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setGraph(containerView: graphView)
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: navigationBarHeight)
        navigationController?.navigationBar.barTintColor = UIColor.mainGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    func setTopSideView(){
        topSideView.backgroundColor = UIColor(patternImage: UIImage(named: "homeTopSideViewImg")!)
        topSideView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 28)
        
        topSideLabel.text = "\(username)님의\n기록을 살펴볼까요?"
        topSideLabel.numberOfLines = 0
    }
    
    func attributedText(withString string: String, boldString: String, font: UIFont) -> String {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: font])
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
        let frame : CGRect = CGRect(x: 0, y: 0, width: self.graphView.frame.width, height: self.graphView.frame.height)
        let barGraphView = ScrollableGraphView(frame: frame, dataSource: self)
        let barPlot = BarPlot(identifier: "bar")
        
        barPlot.barWidth = 10
        barPlot.barLineWidth = 0
        barPlot.barColor = UIColor.barColorGreen
        
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
        referenceLines.referenceLineLabelColor = UIColor.graphTicksBlue
        referenceLines.dataPointLabelColor = UIColor.graphTicksBlue
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

extension MainHomeViewController: UITableViewDelegate {
}

extension MainHomeViewController : UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return graphDetailList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0;
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "graphDetailTableViewCell") as! HomeGraphDetailTableViewCell
        
        cell.contentView.backgroundColor = UIColor.mainBackgroudGray

        cell.portfolioTitle?.text = graphDetailList[indexPath.row].portfolioTitle!
        cell.portfolioDuration?.text = graphDetailList[indexPath.row].portfolioDuration!
        
     return cell
     }
    
}

