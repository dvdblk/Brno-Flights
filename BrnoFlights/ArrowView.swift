//
//  ArrowView.swift
//  BrnoFlights
//
//  Created by David on 28/02/2016.
//  Copyright © 2016 Revion. All rights reserved.
//

import UIKit

// extension from https://gist.github.com/mwermuth/07825df27ea28f5fc89a

extension UIBezierPath {
    
    class func getAxisAlignedArrowPoints(_ points: inout Array<CGPoint>, forLength: CGFloat, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat ) {
        
        let tailLength = forLength - headLength
        points.append(CGPoint(x: 0, y: tailWidth/2))
        points.append(CGPoint(x: tailLength, y: tailWidth/2))
        points.append(CGPoint(x: tailLength, y: headWidth/2))
        points.append(CGPoint(x: forLength, y: 0))
        points.append(CGPoint(x: tailLength, y: -headWidth/2))
        points.append(CGPoint(x: tailLength, y: -tailWidth/2))
        points.append(CGPoint(x: 0, y: -tailWidth/2))
        
    }

    class func transformForStartPoint(_ startPoint: CGPoint, endPoint: CGPoint, length: CGFloat) -> CGAffineTransform{
        let cosine: CGFloat = (endPoint.x - startPoint.x)/length
        let sine: CGFloat = (endPoint.y - startPoint.y)/length
        
        return CGAffineTransform(a: cosine, b: sine, c: -sine, d: cosine, tx: startPoint.x, ty: startPoint.y)
    }
    
    class func bezierPathWithArrowFromPoint(_ startPoint:CGPoint, endPoint: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> UIBezierPath {
        
        let xdiff: Float = Float(endPoint.x) - Float(startPoint.x)
        let ydiff: Float = Float(endPoint.y) - Float(startPoint.y)
        let length = hypotf(xdiff, ydiff)
        
        var points = [CGPoint]()
        self.getAxisAlignedArrowPoints(&points, forLength: CGFloat(length), tailWidth: tailWidth, headWidth: headWidth, headLength: headLength)
        
        let transform: CGAffineTransform = self.transformForStartPoint(startPoint, endPoint: endPoint, length:  CGFloat(length))
        
        let cgPath: CGMutablePath = CGMutablePath()
        cgPath.addLines(between: points, transform: transform)
        //CGPathAddLines(cgPath, &transform, points, 7)
        cgPath.closeSubpath()
        
        let uiPath: UIBezierPath = UIBezierPath(cgPath: cgPath)
        return uiPath
    }
}

class ArrowView: UIView {
    
    var transfers = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        self.contentMode = .redraw
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        let myMid = self.bounds.midY - 1
        let myWidth = self.bounds.width
        let radius:CGFloat = 5
        let arrow = UIBezierPath.bezierPathWithArrowFromPoint(CGPoint(x: 5,y: myMid), endPoint: CGPoint(x: myWidth-5,y: myMid), tailWidth: 2, headWidth: 6, headLength: 6)
        UIColor.black.setFill()
        arrow.fill()
        
        func drawCircle(_ startpoint: CGFloat) {
            let point = CGPoint(x: startpoint, y: myMid - radius/2)
            let myCircle = BasicCircle(withPosition: point, size: radius)
            myCircle.color.setFill()
            UIBezierPath(ovalIn: myCircle.rectangle).fill()
        }
        
        let myW = (myWidth-16) / CGFloat(transfers+1)
        for i in 0..<transfers {
            drawCircle(radius/2+myW*CGFloat(i+1))
        }
    }

}
