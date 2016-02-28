//
//  FlightsViewController.swift
//  BrnoFlights
//
//  Created by David on 27/02/2016.
//  Copyright © 2016 Revion. All rights reserved.
//

import UIKit

let flightCellIdentifier = "flight"

class FlightsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var flightData = FlightData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "myCell", bundle: nil), forCellReuseIdentifier: flightCellIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showInfoSegue" {
            if let destVC = segue.destinationViewController as? InfoViewController {
                destVC.parentVC = self
                if let myIndex = self.tableView.indexPathForSelectedRow?.section {
                    let data = flightData.flights[myIndex]
                    destVC.singleFlightData = data.route
                    destVC.price = data.price
                    destVC.duration = data.flyDuration
                    destVC.date = data.date
                }
            }
        }
    }

    @IBAction func sortBtnPressed(sender: UIButton) {
        print(sender.tag)
    }
}


extension FlightsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(flightCellIdentifier) as! FlightsTableViewCell
        // Data
        let dataCell = flightData.flights[indexPath.section]
        cell.durationLabel.text = dataCell.flyDuration
        cell.priceLabel.text = dataCell.price.toEur
        cell.flightToLabel.text = dataCell.cityTo
        cell.flightFromLabel.text = dataCell.cityFrom
        cell.flightFromTimeLabel.text = dataCell.dTime.toHour
        cell.flightToTimeLabel.text = dataCell.aTime.toHour
        cell.dateLabel.text = dataCell.date
        cell.arrowView.transfers = dataCell.transfers
        // UI
        //cell.layer.masksToBounds = false
        cell.clipsToBounds = false
        cell.layer.shadowOffset = CGSizeMake(0, 1)
        cell.layer.shadowOpacity = 0.9
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowRadius = 2
        let shFrame: CGRect = cell.layer.bounds
        let shPath: CGPathRef = UIBezierPath(rect: shFrame).CGPath
        cell.layer.shadowPath = shPath
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return flightData.flights.count
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clearColor()
        return footer
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UIScreen.mainScreen().bounds.width * 0.02
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showInfoSegue", sender: self)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
