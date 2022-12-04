//
//  ViewController.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 01.12.2022.
//

import UIKit

class MainWeatherVC: UIViewController {

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
    private lazy var collectionView: UICollectionView = {
        layout.scrollDirection = .horizontal
       // layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
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
    
    private var viewModel: WeatherModelProtocol
    
    init(viewModel: WeatherModelProtocol) {
        self.viewModel = viewModel
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

    private func setViews() {
        view.addSubview(blueView)
        view.addSubview(detailsForecast)
        view.addSubview(collectionView)
        view.addSubview(dailyForecast)
        view.addSubview(futureForecastButton)
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
            
            collectionView.topAnchor.constraint(equalTo: detailsForecast.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.09522),
            
            dailyForecast.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            dailyForecast.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            dailyForecast.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.57),
            dailyForecast.heightAnchor.constraint(equalTo: dailyForecast.widthAnchor, multiplier: 0.11),
            
            futureForecastButton.centerYAnchor.constraint(equalTo: dailyForecast.centerYAnchor),
            futureForecastButton.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            futureForecastButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2613),
            futureForecastButton.heightAnchor.constraint(equalTo: futureForecastButton.widthAnchor, multiplier: 0.24096),
            
            
        ])
    }
}

//MARK: uicollectionView
extension MainWeatherVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        cell.backgroundColor = .blue
        
        return cell
    }
    
}
