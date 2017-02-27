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
        self.tableView.register(UINib(nibName: "myCell", bundle: nil), forCellReuseIdentifier: flightCellIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.durationLabel.text = self.duration
        self.priceLabel.text = self.price.toEur
        self.orderBtn.layer.cornerRadius = 10
    }

}

extension FlightsInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: flightCellIdentifier) as! FlightsTableViewCell
        cell.hide()
        let data = singleFlightData[indexPath.row]
        cell.flightFromLabel.text = "\(data.cityFrom)(\(data.flyFrom))"
        cell.flightFromTimeLabel.text = data.dTime.toHour
        cell.flightToLabel.text = "\(data.cityTo)(\(data.flyTo))"
        cell.flightToTimeLabel.text = data.aTime.toHour
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singleFlightData.count
    }
    
}
