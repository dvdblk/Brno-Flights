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
    private var position: CGPoint
    private var size: CGSize {
        return CGSize(width: sideSize * sizeMultiplier, height: sideSize * sizeMultiplier)
    }
    private var sideSize: CGFloat
    private var sizeMultiplier: CGFloat
    var rectangle: CGRect {
        return CGRect(origin: position, size: size)
    }
    private var color: UIColor
    
    init(withPosition tempPos: CGPoint = CGPointZero, size tempSize: CGFloat = 0, color tempColor: UIColor = UIColor.blackColor()) {
        position = tempPos
        sizeMultiplier = 1
        sideSize = tempSize
        color = tempColor
    }
    
}

class AdvancedCircle: BasicCircle {
    override init(withPosition tempPos: CGPoint, size tempSize: CGFloat, color tempColor: UIColor) {
        super.init(withPosition: tempPos, size: tempSize, color: tempColor)
        sizeMultiplier = 1.5
    }
}


/*
 let patternSize = 2
 let drawSize = CGSize(width: patternSize, height: patternSize)
 UIGraphicsBeginImageContextWithOptions(drawSize, false, 0.0)
 let drawingContext = UIGraphicsGetCurrentContext()
 CGContextSetFillColorWithColor(drawingContext, UIColor.blackColor().CGColor)
 CGContextSetLineWidth(drawingContext, 10)
 CGContextAddRect(drawingContext, CGRect(x: 0, y: 0, width: drawSize.width/2, height: drawSize.height/2))
 CGContextAddRect(drawingContext, CGRect(x: drawSize.width/2, y: drawSize.height/2, width: drawSize.width, height: drawSize.height))
 CGContextDrawPath(drawingContext, .Fill)
 let image = UIGraphicsGetImageFromCurrentImageContext()
 UIGraphicsEndImageContext()
 UIColor(patternImage: image).setFill()
 */
