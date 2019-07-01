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

    
    @IBOutlet weak var topSideView: UIView!
    @IBOutlet weak var topSideLabel: UILabel!
    @IBOutlet weak var graphView: UIView!
    
    var username: String = "박경선"
    
    //    let fontSize = UIFont.boldSystemFont(ofSize: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackgroudGray
        let scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        setNavigationBar()
        setTopSideView()
        graphView.roundCorners(corners: [.allCorners], radius: 5)
        graphView.dropShadow(color: UIColor.black, offSet: CGSize(width: 0, height: 1), opacity: 0.1, radius: 5)
        graphView.addSubview(setGraph())
        
    }
    
    func setNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor.mainGreen
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setTopSideView(){
        topSideView.backgroundColor = UIColor.mainGreen
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
    
    func setGraph() -> ScrollableGraphView {
        let frame: CGRect = CGRect(x: 0.0, y: 0.0, width: graphView.frame.width, height: graphView.frame.height)
        let barGraphView = ScrollableGraphView(frame: frame, dataSource: self)
        let barPlot = BarPlot(identifier: "bar")
        barPlot.barWidth = 10
        barPlot.barLineWidth = 1
        barPlot.barLineColor = UIColor.lightGray
        barPlot.barColor = UIColor.barColorGreen
        
        barPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        barPlot.animationDuration = 1.5
        
        barGraphView.topMargin = 16
        barGraphView.bottomMargin = 26
        barGraphView.dataPointSpacing = 27
        barGraphView.direction = ScrollableGraphViewDirection.leftToRight
        
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 7)
        referenceLines.dataPointLabelFont = UIFont.boldSystemFont(ofSize: 14)
        referenceLines.referenceLineColor = UIColor.graphLineGray
        referenceLines.referenceLineLabelColor = UIColor.graphTicksBlue
        referenceLines.dataPointLabelColor = UIColor.graphTicksBlue
        referenceLines.shouldShowReferenceLines = true
        
        
        barGraphView.backgroundFillColor = UIColor.graphBackgroundWhite
        barGraphView.shouldAnimateOnStartup = false
        
        barGraphView.rangeMax = barPlotData.max()!
        barGraphView.rangeMin = 0
        
        barGraphView.addPlot(plot: barPlot)
        barGraphView.addReferenceLines(referenceLines: referenceLines)
        
        return barGraphView
    }
}
