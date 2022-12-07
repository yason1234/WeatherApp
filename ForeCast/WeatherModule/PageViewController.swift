//
//  PageViewController.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 06.12.2022.
//

import UIKit

class PageViewController: UIPageViewController {

    private lazy var VC = [MainWeatherVC]()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        
        VC = [MainWeatherVC(viewModel: WeatherModel()), MainWeatherVC(viewModel: WeatherModel())]
        setViewControllers([VC[0]], direction: .forward, animated: true)
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
        if let index = VC.firstIndex(of: vc), index > 0 {
            return VC[index - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? MainWeatherVC else { return nil }
        if let index = VC.firstIndex(of: vc), index < VC.count - 1 {
            return VC[index + 1]
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        VC.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
    
}
