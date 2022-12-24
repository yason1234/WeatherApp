//
//  AddingCityViewController.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 10.12.2022.
//

import UIKit
import CoreData

class AddingCityViewController: UIViewController, WeatherModelProtocol {
    
    let button: UIButton = {
        let button = UIButton()
//        button.addTarget(AddingCityViewController.self, action: #selector(pressButton), for: .touchUpInside)
        button.setTitle("Добавить город", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        view.addSubview(button)
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
            button.heightAnchor.constraint(equalTo: self.button.widthAnchor, multiplier: 0.5)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.layer.cornerRadius = self.button.bounds.height / 5
    }
    
    @objc private func pressButton() {
        
        Helper.shared.addCoordinate(vc: self)
//        guard let parent = parent as? PageViewController else {
//            return
//        }
//
//        let alertController = UIAlertController(title: "Add City", message: "Enter name of city", preferredStyle: .alert)
//        alertController.addTextField()
//        let action = UIAlertAction(title: "Ok", style: .default) { _ in
//            guard let city = alertController.textFields?.first?.text, !city.isEmpty else { return }
//
//            NetworkManager.shared.getCoordinate(city: city) { coordinate, error in
//                if error != nil {
//                    print(error?.localizedDescription)
//                }
//                guard let coordinate else { return }
//                CoreDataManager.shared.addCity(atPoint: (coordinate.latitude, coordinate.longitude)) {
//
//                    NetworkManager.shared.downloadWeather(atPoint: (coordinate.latitude, coordinate.longitude)) { weatherCodable in
//                        guard let weatherCodable else { return }
//
//                        CoreDataManager.shared.createWeather(weather: weatherCodable) {
//                            DispatchQueue.main.async {
//                                parent.addVC()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//
//        alertController.addAction(action)
//        self.present(alertController, animated: true)
    }
}
