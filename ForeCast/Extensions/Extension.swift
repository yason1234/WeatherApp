//
//  Extension.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 09.12.2022.
//

import Foundation

extension Forecast {
    var hourSorted: [Hour] {
        return (hour?.sortedArray(using: [NSSortDescriptor(key: "hour", ascending: true)])) as! [Hour]
    }
}

extension Weather {
    var forecastSorted: [Forecast] {
        //return (forecast?.sortedArray(using: [NSSortDescriptor(key: "hour", ascending: true)])) as! [Forecast]
        return forecast?.allObjects as! [Forecast]
    }
}

extension Double {
    func toDate() -> String {
        let date = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date as Date)
    }
}

extension Hour: Comparable {
    public static func < (lhs: Hour, rhs: Hour) -> Bool {
        return lhs.hourTs < rhs.hourTs
    }
}
