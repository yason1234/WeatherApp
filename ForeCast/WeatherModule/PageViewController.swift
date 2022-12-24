//
//  PageViewController.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 06.12.2022.
//

import UIKit
import CoreData

class PageViewController: UIPageViewController {

    private lazy var VC: [UIViewController] = [AddingCityViewController()]
    private var allVC: [MainWeatherVC] {
        let cities = CoreDataManager.shared.loadCity()
        var array = [MainWeatherVC]()
        for city in cities {
            let info = city.info
            array.append(MainWeatherVC(viewModel: viewModel, point: (info!.lat, info!.lon)))
        }
        return array
    }
    private let viewModel: WeatherModelProtocol = WeatherModel()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        if !allVC.isEmpty {
            setViewControllers([allVC[0]], direction: .forward, animated: true)
        } else {
            setViewControllers([VC[0]], direction: .forward, animated: true)
        }
        self.dataSource = self
        self.delegate = delegate

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? MainWeatherVC else { return nil }
        print(vc)
        if !allVC.isEmpty {
            if let index = allVC.firstIndex(of: vc), index > 0 {
                return allVC[index - 1]
            } else {
                print(allVC.first!)
            }
        } else {
            if let index = VC.firstIndex(of: viewController), index > 0 {
                return VC[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? MainWeatherVC else { return nil }
        if !allVC.isEmpty {
            //return allVC[allVC.count - 1]
            if let index = allVC.firstIndex(of: vc), index < allVC.count - 1 {
                return allVC[index + 1]
            }
        } else {
            if let index = VC.firstIndex(of: viewController), index < VC.count - 1 {
                return VC[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return allVC.isEmpty ? VC.count : allVC.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
    
   func addVC() {
      // self.VC.append(MainWeatherVC(viewModel: viewModel))
       setViewControllers([allVC[0]], direction: .forward, animated: true)
       
    }
}
