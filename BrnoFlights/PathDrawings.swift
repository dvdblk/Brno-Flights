//
//  PathDrawings.swift
//  BrnoFlights
//
//  Created by David Bielik on 04/08/16.
//  Copyright © 2016 Revion. All rights reserved.
//

import Foundation
import UIKit

class BasicCircle {
    fileprivate var origin: CGPoint
    fileprivate var position: CGPoint {
        let tempDiff = (size.height - sideSize) / 2
        return CGPoint(x: origin.x - tempDiff, y: origin.y - tempDiff)
    }
    fileprivate var size: CGSize {
        return CGSize(width: sideSize * sizeMultiplier, height: sideSize * sizeMultiplier)
    }
    fileprivate var sideSize: CGFloat
    fileprivate var sizeMultiplier: CGFloat
    var rectangle: CGRect {
        return CGRect(origin: position, size: size)
    }
    var color: UIColor
    
    init(withPosition tempPos: CGPoint = CGPoint.zero, size tempSize: CGFloat = 0) {
        origin = tempPos
        sizeMultiplier = 1
        sideSize = tempSize
        color = UIColor.black
    }
    
}

class AdvancedCircle: BasicCircle {
    
    override init(withPosition tempPos: CGPoint, size tempSize: CGFloat) {
        super.init(withPosition: tempPos, size: tempSize)
        sizeMultiplier = 1.5
        color = UIColor.green
    }
    
    func finishColor() {
        let tempSize = self.size.height/3
        let drawSize = CGSize(width: tempSize, height: tempSize)
        UIGraphicsBeginImageContextWithOptions(drawSize, false, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        drawingContext?.setFillColor(UIColor.black.cgColor)
        drawingContext?.setLineWidth(10)
        drawingContext?.addRect(CGRect(x: 0, y: 0, width: drawSize.width/2, height: drawSize.height/2))
        drawingContext?.addRect(CGRect(x: drawSize.width/2, y: drawSize.height/2, width: drawSize.width, height: drawSize.height))
        drawingContext?.drawPath(using: .fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.color = UIColor(patternImage: image!)
    }
}

