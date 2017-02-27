//
//  FlightInfoView.swift
//  BrnoFlights
//
//  Created by David Bielik on 27/02/17.
//  Copyright © 2017 Revion. All rights reserved.
//

import Foundation
import UIKit

class FlightInfoView: UIView {
    private let lineWidth: CGFloat = 2
    private let lineHeight: CGFloat = 40
    private let circleRadius: CGFloat = 5
    private lazy var myMid: CGFloat = {
        return self.bounds.midX
    }()
    
    var routesInfo: FlightRoutesInfo? {
        didSet {
            cities = routesInfo?.cities ?? []
            layovers = routesInfo?.layovers ?? []
            setNeedsDisplay()
        }
    }
    
    private var cities = [String]()
    private var layovers = [UnixTime]()
    
    override func awakeFromNib() {
        self.contentMode = .redraw
        self.backgroundColor = UIColor.clear
    }
    
    private func createLine(withYPos yPos: CGFloat) -> UIBezierPath {
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: myMid, y: yPos))
        linePath.addLine(to: CGPoint(x: myMid, y: yPos+lineHeight))
        linePath.lineWidth = lineWidth
        return linePath
    }
    
    private func createDashedLine(withYPos yPos: CGFloat) -> UIBezierPath {
        let resultLine = createLine(withYPos: yPos)
        let dashes: [CGFloat] = [4.0, 4.0]
        resultLine.lineJoinStyle = .round
        resultLine.setLineDash(dashes, count: dashes.count, phase: 0.0)
        return resultLine
    }
    
    private func circlePoint(fromY y: CGFloat) -> CGPoint {
        return CGPoint(x: myMid-circleRadius/2, y: y)
    }
    
    private func draw(circle: BasicCircle) {
        circle.color.setFill()
        UIColor.black.setStroke()
        let circleBezierPath = UIBezierPath(ovalIn: circle.rectangle)
        circleBezierPath.fill()
        circleBezierPath.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        var currentYPos: CGFloat = 10
        var yPositions: [CGFloat] = []
        func currentY() -> CGFloat {
            let tempPos = currentYPos
            yPositions.append(currentYPos)
            currentYPos += 40
            return tempPos
        }
        
        for i in 0..<cities.count-1 {
            UIColor.black.set()
            createLine(withYPos: currentY()).stroke()
            if layovers[i] > 3600 {
                UIColor.gray.set()
                createDashedLine(withYPos: currentY()).stroke()
            }
        }
        
        draw(circle: AdvancedCircle(withPosition: circlePoint(fromY: yPositions[0]), size: circleRadius))
        for i in 1..<yPositions.count {
            draw(circle: BasicCircle(withPosition: circlePoint(fromY: yPositions[i]), size: circleRadius))
        }
        let finishCircle = AdvancedCircle(withPosition: circlePoint(fromY: currentYPos), size: circleRadius)
        finishCircle.finishColor()
        draw(circle: finishCircle)
    }
}
