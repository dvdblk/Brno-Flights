//
//  FlightsViewController.swift
//  BrnoFlights
//
//  Created by David on 27/02/2016.
//  Copyright © 2016 Revion. All rights reserved.
//

import UIKit

let flightCellIdentifier = "flight"
let flightInfoCellIdentifier = "flightInfo"
let cellOffset = UIScreen.main.bounds.width * 0.02

class FlightsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var sortButtons: [UIButton]!
    var flightData = FlightData()
    var previousTag = -1
    var selectedCellIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "FlightsTableViewCell", bundle: nil), forCellReuseIdentifier: flightCellIdentifier)
        self.tableView.register(UINib(nibName: "FlightsInfoTableViewCell", bundle: nil), forCellReuseIdentifier: flightInfoCellIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfoSegue" {
            if let destVC = segue.destination as? FlightsInfoViewController {
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

    @IBAction func sortBtnPressed(_ sender: UIButton) {
        var compareClosure: (Int, Int) -> Bool = { $0 < $1 }
        if sender.tag == previousTag {
            compareClosure = { $0 > $1 }
            previousTag = -1
        } else {
            previousTag = sender.tag
        }
        
        if sender.tag == 0 {
            flightData.flights.sort(by: {compareClosure($0.price, $1.price)})
        } else if sender.tag == 1 {
            flightData.flights.sort(by: {compareClosure($0.dTime, $1.dTime)})
        } else {
            flightData.flights.sort(by: {compareClosure($0.transfers, $1.transfers)})
        }
        self.tableView.reloadData()
        self.tableView.setContentOffset(CGPoint.zero, animated: true)
    }
}


extension FlightsViewController: UITableViewDataSource, UITableViewDelegate {
    private func flightCell(atIndexPath indexPath: IndexPath) -> FlightsTableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: flightCellIdentifier) as! FlightsTableViewCell
        let dataCell = flightData.flights[indexPath.section]
        cell.durationLabel.text = dataCell.flyDuration
        cell.priceLabel.text = dataCell.price.toEur
        cell.flightToLabel.text = dataCell.cityTo
        cell.flightFromLabel.text = dataCell.cityFrom
        cell.flightFromTimeLabel.text = dataCell.dTime.toHour
        cell.flightToTimeLabel.text = dataCell.aTime.toHour
        cell.dateLabel.text = dataCell.date
        cell.arrowView.transfers = dataCell.transfers
        return cell
    }
    
    private func flightInfoCell(atIndexPath indexPath: IndexPath) -> FlightsInfoTableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: flightInfoCellIdentifier) as! FlightsInfoTableViewCell
        let dataCell = flightData.flights[indexPath.section]
        cell.routesView.routesInfo = DataCell.createFlightRoutesInfo(from: dataCell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedCellIndexPath == indexPath {
            return flightInfoCell(atIndexPath: indexPath)
        }
        return flightCell(atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return flightData.flights.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return cellOffset
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indexPathsToReload = [indexPath]
        if let previouslySelectedIndexPath = selectedCellIndexPath, previouslySelectedIndexPath == indexPath {
            indexPathsToReload.append(previouslySelectedIndexPath)
            selectedCellIndexPath = nil
            tableView.reloadRows(at: indexPathsToReload, with: .fade)
        } else {
            selectedCellIndexPath = indexPath
            tableView.reloadRows(at: indexPathsToReload, with: .fade)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        
        
        // segue to FlightsInfoVC...
        /*self.performSegue(withIdentifier: "showInfoSegue", sender: self)
        self.tableView.deselectRow(at: indexPath, animated: true)*/
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCellIndexPath == indexPath {
            return 250
        }
        return 80
    }
}
