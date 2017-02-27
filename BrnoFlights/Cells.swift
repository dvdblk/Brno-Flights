//
//  FlightsTableViewCell.swift
//  BrnoFlights
//
//  Created by David on 27/02/2016.
//  Copyright © 2016 Revion. All rights reserved.
//

import UIKit

class BaseFlightsTableViewCell: UITableViewCell {
    private var previousFrame: CGFloat = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = false
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.9
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2
        self.selectionStyle = .none
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var tempFrame = newValue
            let inset: CGFloat = cellOffset
            tempFrame.origin.x += inset
            if previousFrame != tempFrame.size.width {
                tempFrame.size.width -= 2 * inset
                previousFrame = tempFrame.size.width
            }
            super.frame = tempFrame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shPath: CGPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowPath = shPath
    }

}

class FlightsTableViewCell: BaseFlightsTableViewCell {

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
        self.durationLabel.isHidden = true
        self.layer.shadowOpacity = 0
    }
}

class FlightsInfoTableViewCell: BaseFlightsTableViewCell {
    
    @IBOutlet weak var routesView: FlightInfoView!
}
