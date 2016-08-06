//
//  FlightsTableViewCell.swift
//  BrnoFlights
//
//  Created by David on 27/02/2016.
//  Copyright © 2016 Revion. All rights reserved.
//

import UIKit

class FlightsTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var flightFromLabel: UILabel!
    @IBOutlet weak var flightFromTimeLabel: UILabel!
    @IBOutlet weak var flightToLabel: UILabel!
    @IBOutlet weak var flightToTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var arrowView: ArrowView!
    
    var editedSize: CGFloat = 0.0
    
    func hide() {
        self.dateLabel.removeFromSuperview()
        self.priceLabel.removeFromSuperview()
        self.durationLabel.hidden = true
        self.layer.shadowOpacity = 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = false
        self.layer.shadowOffset = CGSizeMake(1, 1)
        self.layer.shadowOpacity = 0.9
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowRadius = 2
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var tempFrame = newValue
            let inset: CGFloat = cellOffset
            print("edited size before set: \(editedSize)")
            if editedSize != tempFrame.size.width - 2*inset || editedSize != tempFrame.size.width {
                editedSize = tempFrame.size.width
                print("edited size after set: \(editedSize)")
                tempFrame.origin.x += inset
                tempFrame.size.width -= 2 * inset
            }
            super.frame = tempFrame
            print(tempFrame.width)
            print()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shFrame: CGRect = self.bounds
        let shPath: CGPathRef = UIBezierPath(rect: shFrame).CGPath
        self.layer.shadowPath = shPath
    }
}
