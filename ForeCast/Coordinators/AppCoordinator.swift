//
//  AppCoordinator.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 01.12.2022.
//

import UIKit

final class AppCoordinator {
    
    func start() -> UIViewController {
        let viewModel = WeatherModel()
        return UINavigationController(rootViewController: PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal))//MainWeatherVC(viewModel: viewModel))
    }
}
