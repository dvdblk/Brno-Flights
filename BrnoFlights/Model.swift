//
//  Model.swift
//  BrnoFlights
//
//  Created by David on 28/02/2016.
//  Copyright © 2016 Revion. All rights reserved.
//

import Foundation

typealias Price = Int
typealias UnixTime = Int

extension Price {
    var toEur: String {
        return "\(self) €"
    }
}

extension UnixTime {
    func formatType(form: String) -> NSDateFormatter {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    var dateFull: NSDate {
        return NSDate(timeIntervalSince1970: Double(self))
    }
    var toHour: String {
        return formatType("HH:mm").stringFromDate(dateFull)
    }
    var toDay: String {
        return formatType("MMM d, y").stringFromDate(dateFull)
    }
}

struct DataCell {
    var date: String {
        return dTime.toDay
    }
    var flyTo: String = "ABC"
    var flyDuration: String = "2h"
    var price: Price = 1337
    var cityTo: String = "London"
    var flyFrom: String = "DEF"
    var dTime: UnixTime = 0
    var cityFrom: String = "Bratislava"
    var aTime: UnixTime = 0
    var transfers: Int = 0
    var route: [DataCell] = []
}

class FlightData {
    var flights: [DataCell] = []
    var parser = Parser()
    
    init() {
        self.flights = parser.parseJson()
    }
}

class Parser {
    
    var json: JSON!
    
    func parseJson() -> [DataCell] {
        var tempDCArr: [DataCell] = []
        func parse(j: JSON) -> DataCell {
            var tempDC = DataCell()
            tempDC.flyTo = j["flyTo"].stringValue
            tempDC.flyDuration = j["fly_duration"].stringValue
            tempDC.price = j["price"].intValue
            tempDC.cityTo = j["cityTo"].stringValue
            tempDC.flyFrom = j["flyFrom"].stringValue
            tempDC.dTime = j["dTime"].intValue
            tempDC.cityFrom = j["cityFrom"].stringValue
            tempDC.aTime = j["aTime"].intValue
            let route = j["route"]
            let transfers = route.count
            tempDC.transfers = transfers
            for i in 0..<transfers {
                tempDC.route.append(parse(route[i]))
            }
            return tempDC
        }
        
        for (_, subJson):(String, JSON) in json {
            tempDCArr.append(parse(subJson))
        }
        return tempDCArr
    }
    
    init() {
        if let path = NSBundle.mainBundle().pathForResource("flights", ofType: "json") {
            if let jsonData = NSData(contentsOfFile: path) {
                self.json = JSON(data: jsonData)["data"]
            }
        }
    }
}

