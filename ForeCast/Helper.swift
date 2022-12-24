//
//  Helper.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 02.12.2022.
//

import UIKit

final class Helper {
    static let shared = Helper()
    
    let backColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
    
    func addCoordinate(vc: UIViewController) {
        
        guard let parent = vc.parent as? PageViewController else {
            return
        }
        
        let alertController = UIAlertController(title: "Add City", message: "Enter name of city", preferredStyle: .alert)
        alertController.addTextField()
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let city = alertController.textFields?.first?.text, !city.isEmpty else { return }
            
            NetworkManager.shared.getCoordinate(city: city) { coordinate, error in
                if error != nil {
                    print(error?.localizedDescription)
                }
                guard let coordinate else { return }
                CoreDataManager.shared.addCity(atPoint: (coordinate.latitude, coordinate.longitude)) {
                    
                    NetworkManager.shared.downloadWeather(atPoint: (coordinate.latitude, coordinate.longitude)) { weatherCodable in
                        guard let weatherCodable else { return }
                        
                        CoreDataManager.shared.createWeather(weather: weatherCodable) {
                            DispatchQueue.main.async {
                                parent.addVC()
                            }
                        }
                    }
                }
            }
        }
        
        alertController.addAction(action)
        vc.present(alertController, animated: true)
    }
}
