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
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topSideView: UIView!
    @IBOutlet weak var topSideLabel: UILabel!
    @IBOutlet weak var graphView: UIView!
    
   
    var username: String = "박경선"
    
    
    //    let fontSize = UIFont.boldSystemFont(ofSize: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBarHeight = 64 as CGFloat
        
        let scrollViewContentWidth = view.frame.width as CGFloat
        let scrollViewContentHeight = tableView.frame.height + topSideView.frame.height + graphView.frame.height + navigationBarHeight + 44 as CGFloat
        
        scrollView.bounces = false
        
        view.backgroundColor = UIColor.mainBackgroudGray
//        let scrollView = UIScrollView(frame: view.bounds)
//        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: scrollViewContentWidth, height: scrollViewContentHeight)
//        view.addSubview(topSideView)
        
        setNavigationBar()
        setTopSideView()
        graphView.roundCorners(corners: [.allCorners], radius: 5)
        graphView.dropShadow(color: UIColor.shadow, offSet: CGSize.zero, opacity: 1.0, radius: 5)
//        graphView.addSubview(setGraph())
//        setGraph(containerView: graphView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setGraph(containerView: graphView)
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
        
        barGraphView.roundCorners(corners: [.allCorners], radius: 5)
        barGraphView.dropShadow(color: UIColor.shadow, offSet: CGSize.zero, opacity: 1.0, radius: 5)
        containerView.addSubview(barGraphView)
    }
    
    func drawReferenceLine(_ containerView: UIView){
        
    }
    
//    private func addLine(from: CGPoint, to: CGPoint, withGaps gaps: [(start: CGFloat, end: CGFloat)], in path: UIBezierPath) {
//
//        // If there are no gaps, just add a single line.
//        if(gaps.count <= 0) {
//            addLine(from: from, to: to, in: path)
//        }
//            // If there is only 1 gap, it's just two lines.
//        else if (gaps.count == 1) {
//
//            let gapLeft = CGPoint(x: gaps.first!.start, y: from.y)
//            let gapRight = CGPoint(x: gaps.first!.end, y: from.y)
//
//            addLine(from: from, to: gapLeft, in: path)
//            addLine(from: gapRight, to: to, in: path)
//        }
//            // If there are many gaps, we have a series of intermediate lines.
//        else {
//
//            let firstGap = gaps.first!
//            let lastGap = gaps.last!
//
//            let firstGapLeft = CGPoint(x: firstGap.start, y: from.y)
//            let lastGapRight = CGPoint(x: lastGap.end, y: to.y)
//
//            // Add the first line to the start of the first gap
//            addLine(from: from, to: firstGapLeft, in: path)
//
//            // Add lines between all intermediate gaps
//            for i in 0 ..< gaps.count - 1 {
//
//                let startGapEnd = gaps[i].end
//                let endGapStart = gaps[i + 1].start
//
//                let lineStart = CGPoint(x: startGapEnd, y: from.y)
//                let lineEnd = CGPoint(x: endGapStart, y: from.y)
//
//                addLine(from: lineStart, to: lineEnd, in: path)
//            }
//
//            // Add the final line to the end
//            addLine(from: lastGapRight, to: to, in: path)
//        }
//    }
//
//    private func addLine(from: CGPoint, to: CGPoint, in path: UIBezierPath) {
//        path.move(to: from)
//        path.addLine(to: to)
//    }
}
