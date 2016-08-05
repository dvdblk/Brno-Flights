//
//  FlightsViewController.swift
//  BrnoFlights
//
//  Created by David on 27/02/2016.
//  Copyright © 2016 Revion. All rights reserved.
//

import UIKit

let flightCellIdentifier = "flight"
let cellOffset = UIScreen.mainScreen().bounds.width * 0.02

class FlightsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var sortButtons: [UIButton]!
    var flightData = FlightData()
    var previousTag = -1
    var selectedCellIndexPath: NSIndexPath?
    
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
            if let destVC = segue.destinationViewController as? FlightsInfoViewController {
                destVC.parentVC = self
                if let myIndex = self.tableView.indexPathForSelectedRow?.section {
                    let data = flightData.flights[myIndex]
                    destVC.singleFlightData = data.route
                    destVC.price = data.price
                    destVC.duration = data.flyDuration
                    destVC.title = data.date
                }
            }
        }
    }

    @IBAction func sortBtnPressed(sender: UIButton) {
        var compareClosure: (Int, Int) -> Bool = { $0 < $1 }
        if sender.tag == previousTag {
            compareClosure = { $0 > $1 }
            previousTag = -1
        } else {
            previousTag = sender.tag
        }
        
        if sender.tag == 0 {
            flightData.flights.sortInPlace({compareClosure($0.price, $1.price)})
        } else if sender.tag == 1 {
            flightData.flights.sortInPlace({compareClosure($0.dTime, $1.dTime)})
        } else {
            flightData.flights.sortInPlace({compareClosure($0.transfers, $1.transfers)})
        }
        self.tableView.reloadData()
        self.tableView.setContentOffset(CGPoint.zero, animated: true)
    }
}


extension FlightsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(flightCellIdentifier) as! FlightsTableViewCell
        let dataCell = flightData.flights[indexPath.section]
        cell.durationLabel.text = dataCell.flyDuration
        cell.priceLabel.text = dataCell.price.toEur
        cell.flightToLabel.text = dataCell.cityTo
        cell.flightFromLabel.text = dataCell.cityFrom
        cell.flightFromTimeLabel.text = dataCell.dTime.toHour
        cell.flightToTimeLabel.text = dataCell.aTime.toHour
        cell.dateLabel.text = dataCell.date
        cell.arrowView.transfers = dataCell.transfers
        cell.arrowView.setNeedsDisplay()
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
        return cellOffset
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let tempIndexPath = selectedCellIndexPath where tempIndexPath == indexPath {
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
        }
        //tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
 
        
        
        
        
        //self.performSegueWithIdentifier("showInfoSegue", sender: self)
        //self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    /*func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110.0
    }*/
}
