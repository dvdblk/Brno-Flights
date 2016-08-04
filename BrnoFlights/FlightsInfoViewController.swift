//
//  FlightsInfoViewController.swift
//  BrnoFlights
//
//  Created by David on 27/02/2016.
//  Copyright © 2016 Revion. All rights reserved.
//

import UIKit

class FlightsInfoViewController: UIViewController {
    
    @IBOutlet weak var orderBtn: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var singleFlightData: [DataCell] = []
    var duration: String!
    var date: String!
    var price: Price!
    
    var parentVC: FlightsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "myCell", bundle: nil), forCellReuseIdentifier: flightCellIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.durationLabel.text = self.duration
        self.priceLabel.text = self.price.toEur
        self.orderBtn.layer.cornerRadius = 10
    }

}

extension FlightsInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier(flightCellIdentifier) as! FlightsTableViewCell
        cell.hide()
        let data = singleFlightData[indexPath.row]
        cell.flightFromLabel.text = "\(data.cityFrom)(\(data.flyFrom))"
        cell.flightFromTimeLabel.text = data.dTime.toHour
        cell.flightToLabel.text = "\(data.cityTo)(\(data.flyTo))"
        cell.flightToTimeLabel.text = data.aTime.toHour
        cell.selectionStyle = .None
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singleFlightData.count
    }
    
}
