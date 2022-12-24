//
//  AppCoordinator.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 01.12.2022.
//

import UIKit

final class AppCoordinator {
    
    func start() -> UIViewController {
        return UINavigationController(rootViewController: PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal))
    }
}
