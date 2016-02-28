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
}

class Parser

