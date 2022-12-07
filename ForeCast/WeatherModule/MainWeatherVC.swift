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
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        return tableView
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
        view.addSubview(tableView)
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
            collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.103),
            
            dailyForecast.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            dailyForecast.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            dailyForecast.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.57),
            dailyForecast.heightAnchor.constraint(equalTo: dailyForecast.widthAnchor, multiplier: 0.11),
            
            futureForecastButton.centerYAnchor.constraint(equalTo: dailyForecast.centerYAnchor),
            futureForecastButton.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            futureForecastButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2613),
            futureForecastButton.heightAnchor.constraint(equalTo: futureForecastButton.widthAnchor, multiplier: 0.24096),
            
            tableView.topAnchor.constraint(equalTo: dailyForecast.bottomAnchor, constant: 10),
            tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: blueView.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: uicollectionView
extension MainWeatherVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = blueView.bounds.width - 16 * 5 - 28
        return CGSize(width: width / 6, height: collectionView.bounds.height)
    }
}

//MARK: uiTableView
extension MainWeatherVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
