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
                if let myIndex = tableView.indexPathForSelectedRow?.section {
                    destVC.title = String(myIndex)
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
        //cell.flightFromLabel?.text = String(indexPath.section)
        cell.layer.masksToBounds = false
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
        return 25
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
    }
}
