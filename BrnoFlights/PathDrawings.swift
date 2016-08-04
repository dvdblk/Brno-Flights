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
    private var origin: CGPoint
    private var position: CGPoint {
        let tempDiff = (size.height - sideSize) / 2
        return CGPoint(x: origin.x - tempDiff, y: origin.y - tempDiff)
    }
    private var size: CGSize {
        return CGSize(width: sideSize * sizeMultiplier, height: sideSize * sizeMultiplier)
    }
    private var sideSize: CGFloat
    private var sizeMultiplier: CGFloat
    var rectangle: CGRect {
        return CGRect(origin: position, size: size)
    }
    var color: UIColor
    
    init(withPosition tempPos: CGPoint = CGPointZero, size tempSize: CGFloat = 0) {
        origin = tempPos
        sizeMultiplier = 1
        sideSize = tempSize
        color = UIColor.blackColor()
    }
    
}

class AdvancedCircle: BasicCircle {
    
    override init(withPosition tempPos: CGPoint, size tempSize: CGFloat) {
        super.init(withPosition: tempPos, size: tempSize)
        sizeMultiplier = 1.5
        color = UIColor.greenColor()
    }
    
    func finishColor() {
        let tempSize = self.size.height/3
        let drawSize = CGSize(width: tempSize, height: tempSize)
        UIGraphicsBeginImageContextWithOptions(drawSize, false, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(drawingContext, UIColor.blackColor().CGColor)
        CGContextSetLineWidth(drawingContext, 10)
        CGContextAddRect(drawingContext, CGRect(x: 0, y: 0, width: drawSize.width/2, height: drawSize.height/2))
        CGContextAddRect(drawingContext, CGRect(x: drawSize.width/2, y: drawSize.height/2, width: drawSize.width, height: drawSize.height))
        CGContextDrawPath(drawingContext, .Fill)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.color = UIColor(patternImage: image)
    }
}

