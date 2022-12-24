//
//  Extension.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 09.12.2022.
//

import UIKit
import SwiftSVG

extension Forecast {
    var hourSorted: [Hour] {
        return hour?.sortedArray(using: [NSSortDescriptor(key: "hour", ascending: true)]) as! [Hour]
    }
}

extension Weather {
    var forecastSorted: [Forecast] {
        return (forecast?.allObjects as! [Forecast]).sorted(by: {$0.date! < $1.date!})
    }
}

extension Double {
    func toTime() -> String {
        let date = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date as Date)
    }
    
    func toDate() -> String {
        let date = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: date as Date)
    }
}

extension Hour: Comparable {
    public static func < (lhs: Hour, rhs: Hour) -> Bool {
        return lhs.hourTs < rhs.hourTs
    }
}

extension UIView {
    
    func downloadedFrom(link:String) {
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            guard let data = data , error == nil else { return }
            DispatchQueue.main.async { () -> Void in
                let image = UIView(SVGData: data)
                self.addSubview(image)
            }
        }).resume()
    }
}

extension UILabel {
    
    func switchCondition(condition: String) {
        switch condition {
        case "clear":
            self.text = "Ясно"
        case "overcast":
            self.text = "Малооблачно"
        case "cloudy":
            self.text = "Облачно с прояснениями"
        case "partly-cloudy-and-rain":
            self.text = "Малооблачно, дождь"
        case "overcast-thunderstorms-with-rain":
            self.text = "Сильный дождь с грозой"
        case "wet-snow":
            self.text = "Дождь со снегом"
        case "partly-cloudy-and-snow":
            self.text = "Малооблачно, снег"
        case "partly-cloudy":
            self.text = "Малооблачно"
        case "partly-cloudy-and-light-rain":
            self.text = "Небольшой снег"
        case "overcast-and-rain":
            self.text = "Значительная облачность, сильный дожд"
        case "cloudy-and-light-rain":
            self.text = "Облачно, небольшой дождь"
        case "overcast-and-light-rain":
            self.text = "Значительная облачность, небольшой дождь."
        case "cloudy-and-rain":
            self.text = "Облачно, дождь"
        case "light-snow":
            self.text = "Небольшой снег"
        case "partly-cloudy-and-light-snow":
            self.text = "малооблачно, снег"
        case "overcast-and-light-snow":
            self.text = "Небольшой снег"
        case "overcast-and-snow":
            self.text = "Снегопад"
        case "cloudy-and-snow":
            self.text = "Облачно, снег"
            
        default: break
        }
    }
    
    func switchConditionBlueView(condition: String) {
        switch condition {
        case "clear":
            self.text = "Ясно"
        case "overcast":
            self.text = "Малооблачно"
        case "cloudy":
            self.text = "Облачно с прояснениями"
        case "partly-cloudy":
            self.text = "Малооблачно"
        case "drizzle":
            self.text = "Морось"
        case "light-rain":
            self.text = "Небольшой дождь"
        case "rain":
            self.text = "Дождь"
        case "moderate-rain":
            self.text = "Умеренно сильный дождь"
        case "heavy-rain":
            self.text = "Сильный дождь"
        case "continuous-heavy-rain":
            self.text = "Длительный сильный дождь"
        case "showers":
            self.text = "Ливень"
        case "wet-snow":
            self.text = "Дождь со снегом"
        case "light-snow":
            self.text = "Небольшой снег"
        case "snow":
            self.text = "Снег"
        case "snow-showers":
            self.text = "Снегопад"
        case "hail":
            self.text = "Град"
        case "thunderstorm":
            self.text = "гроза"
        case "thunderstorm-with-rain":
            self.text = "Дождь с грозой."
        case "thunderstorm-with-hail":
            self.text = "Гроза с градом"
            
        default: break
        }
    }
}
