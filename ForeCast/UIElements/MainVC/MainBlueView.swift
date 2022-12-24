//
//  MainBlueView.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 02.12.2022.
//

import UIKit

class MainBlueView: UIView {
    
    private lazy var morningTimeLabel = CustomTimeLabel(text: "05:00")
    private lazy var eveningTimeLabel = CustomTimeLabel(text: "11:11")
    private lazy var timeLabel = TimeViewMainVC()
    private lazy var weatherDetailView = WeatherDetailView()
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    private lazy var futureTempView = ForecastTemp()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.text = "13"
        label.textColor = .white
        label.font = .systemFont(ofSize: 36, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var gradusImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "gradus")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = Helper.shared.backColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(morningTimeLabel)
        self.addSubview(eveningTimeLabel)
        self.addSubview(timeLabel)
        self.addSubview(weatherDetailView)
        self.addSubview(statusLabel)
        self.addSubview(tempLabel)
        self.addSubview(gradusImage)
        self.addSubview(futureTempView)
    }
    
    func configureView(fromForecast forecast: Forecast) {
        guard let day = forecast.parts?.day else { return }
        
        morningTimeLabel.text = forecast.sunrise
        eveningTimeLabel.text = forecast.sunset
        tempLabel.text = "\(day.tempAvg)"
        futureTempView.configure(day: day)
        statusLabel.switchConditionBlueView(condition: day.condition!)
        weatherDetailView.configure(fromDay: day)
        
    }
}

extension MainBlueView {
    private func setConstraint() {
        NSLayoutConstraint.activate([
            morningTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            morningTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -26),
            morningTimeLabel.heightAnchor.constraint(equalToConstant: 19),
            morningTimeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.112),

            eveningTimeLabel.centerYAnchor.constraint(equalTo: morningTimeLabel.centerYAnchor),
            eveningTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17),
            eveningTimeLabel.heightAnchor.constraint(equalToConstant: 19),
            eveningTimeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.112),
            
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -21),
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            timeLabel.leadingAnchor.constraint(equalTo: morningTimeLabel.trailingAnchor, constant: 42),
//            timeLabel.trailingAnchor.constraint(equalTo: eveningTimeLabel.leadingAnchor, constant: -47),
            timeLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.09433),
            timeLabel.widthAnchor.constraint(equalTo: timeLabel.heightAnchor, multiplier: 7.55),
            
//            weatherDetailView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 78),
//            weatherDetailView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -78),
            weatherDetailView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherDetailView.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -10),
            weatherDetailView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.141),
            weatherDetailView.widthAnchor.constraint(equalTo: weatherDetailView.heightAnchor, multiplier: 6.26),

            statusLabel.bottomAnchor.constraint(equalTo: weatherDetailView.topAnchor, constant: -8),
            statusLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.659),
            statusLabel.heightAnchor.constraint(equalTo: statusLabel.widthAnchor, multiplier: 0.08),
            statusLabel.centerXAnchor.constraint(equalTo: self.tempLabel.centerXAnchor),

            tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -5),
            tempLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1208),
            tempLabel.heightAnchor.constraint(equalTo: tempLabel.widthAnchor, multiplier: 0.888),

            gradusImage.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: -3),
            gradusImage.topAnchor.constraint(equalTo: tempLabel.topAnchor, constant: 2),
            gradusImage.widthAnchor.constraint(equalTo: tempLabel.widthAnchor, multiplier: 0.111),
            gradusImage.heightAnchor.constraint(equalTo: gradusImage.widthAnchor),
            
            futureTempView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            futureTempView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.127),
            futureTempView.heightAnchor.constraint(equalTo: futureTempView.widthAnchor, multiplier: 0.4545),
            futureTempView.bottomAnchor.constraint(equalTo: tempLabel.topAnchor, constant: -5)
        ])
    }
}
