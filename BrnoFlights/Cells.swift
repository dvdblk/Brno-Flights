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
    
    func hide() {
        self.dateLabel.removeFromSuperview()
        self.priceLabel.removeFromSuperview()
        self.durationLabel.hidden = true
        self.layer.shadowOpacity = 0
    }
    
    override func awakeFromNib() {
        self.clipsToBounds = false
        self.layer.shadowOffset = CGSizeMake(1, 1)
        self.layer.shadowOpacity = 0.9
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowRadius = 2
        super.awakeFromNib()
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            let inset: CGFloat = cellOffset
            var frame = newValue
            frame.origin.x += inset
            frame.size.width -= 2 * inset
            super.frame = frame
        }
    }
    
    override func layoutSubviews() {
        let shFrame: CGRect = self.bounds
        let shPath: CGPathRef = UIBezierPath(rect: shFrame).CGPath
        self.layer.shadowPath = shPath
        super.layoutSubviews()
    }
}
