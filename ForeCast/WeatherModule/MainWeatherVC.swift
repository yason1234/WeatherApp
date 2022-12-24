//
//  ViewController.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 01.12.2022.
//

import UIKit
import CoreData

class MainWeatherVC: UIViewController, WeatherModelProtocol {

    private lazy var blueView = MainBlueView()
    private lazy var detailsForecast: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подробнее на 24 часа"
        label.textAlignment = .right
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var layout = UICollectionViewFlowLayout()
    private lazy var hourCollectionView: UICollectionView = {
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var dailyForecast: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ежедневный прогноз"
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private lazy var futureForecastButton: UIButton = {
        let button = UIButton()
        button.setTitle("25 дней", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.titleLabel?.textAlignment = .right
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var layout2 = UICollectionViewFlowLayout()
    private lazy var forecastCollectionView: UICollectionView = {
        layout2.scrollDirection = .vertical
        layout2.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout2)
        collection.showsHorizontalScrollIndicator = false
        collection.register(MainForecastCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell2")
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var coreDataManager = CoreDataManager.shared
    private lazy var hourlyForecast = [Hour]()
    private lazy var forecast = [Forecast]()

    private var point: (Double, Double)
    
    private var viewModel: WeatherModelProtocol
    
    init(viewModel: WeatherModelProtocol, point: (Double, Double)) {
        self.viewModel = viewModel
        self.point = point
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setViews()
        setConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.shared.downloadWeather(atPoint: point) { [weak self] weather in
            guard let weather else {
                print("not parse")
                return
            }
            self?.coreDataManager.createWeather(weather: weather) {
                self?.coreDataManager.loadForecast(point: self!.point) { weather in
                        guard let weather else {
                            return
                        }
                        DispatchQueue.main.async {
                            self?.hourlyForecast = weather.forecastSorted.first?.hourSorted.sorted(by: {$0 < $1 }) ?? []
                            self?.forecast = weather.forecastSorted
                            self?.hourCollectionView.reloadData()
                            self?.forecastCollectionView.reloadData()
                            self?.blueView.configureView(fromForecast: weather.forecastSorted.first!)
                    }
                }
            }
        }
    }

    private func setViews() {
        view.addSubview(blueView)
        view.addSubview(detailsForecast)
        view.addSubview(hourCollectionView)
        view.addSubview(dailyForecast)
        view.addSubview(futureForecastButton)
        view.addSubview(forecastCollectionView)
        
        parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add"), style: .done, target: self, action: #selector(addWeather))
    }
    
    @objc private func addWeather() {
        Helper.shared.addCoordinate(vc: self)
    }
}

extension MainWeatherVC {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 112),
            blueView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            blueView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.91733),
            blueView.heightAnchor.constraint(equalTo: blueView.widthAnchor, multiplier: 0.616),
            
            detailsForecast.topAnchor.constraint(equalTo: blueView.bottomAnchor, constant: 33),
            detailsForecast.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            detailsForecast.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.564),
            detailsForecast.heightAnchor.constraint(equalTo: detailsForecast.widthAnchor, multiplier: 0.1149),
            
            hourCollectionView.topAnchor.constraint(equalTo: detailsForecast.bottomAnchor, constant: 24),
            hourCollectionView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            hourCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            hourCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.103),
            
            dailyForecast.topAnchor.constraint(equalTo: hourCollectionView.bottomAnchor, constant: 24),
            dailyForecast.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            dailyForecast.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.57),
            dailyForecast.heightAnchor.constraint(equalTo: dailyForecast.widthAnchor, multiplier: 0.11),
            
            futureForecastButton.centerYAnchor.constraint(equalTo: dailyForecast.centerYAnchor),
            futureForecastButton.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            futureForecastButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2613),
            futureForecastButton.heightAnchor.constraint(equalTo: futureForecastButton.widthAnchor, multiplier: 0.24096),
            
            forecastCollectionView.topAnchor.constraint(equalTo: dailyForecast.bottomAnchor, constant: 10),
            forecastCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            forecastCollectionView.widthAnchor.constraint(equalTo: blueView.widthAnchor),
            forecastCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: uicollectionView
extension MainWeatherVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hourCollectionView {
            return hourlyForecast.count
        } else {
            return forecast.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hourCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MainCollectionViewCell   else { return UICollectionViewCell() }

            cell.configureCell(fromHour: hourlyForecast[indexPath.row])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell2", for: indexPath) as? MainForecastCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureCell(fromForecast: forecast[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == hourCollectionView {
            let width = blueView.bounds.width - 16 * 5 - 28
            return CGSize(width: width / 6, height: collectionView.bounds.height)
        } else {
            return CGSize(width: self.blueView.bounds.width, height: self.view.bounds.height * 0.0689)
        }
    }
}


