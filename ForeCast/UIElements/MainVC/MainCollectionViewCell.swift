//
//  MainCollectionViewCell.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 07.12.2022.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = "12:00"
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(named: "sun")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1)
        //label.text = "23"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        self.addSubview(timeLabel)
        self.addSubview(weatherImage)
        self.addSubview(tempLabel)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 0.671, green: 0.737, blue: 0.918, alpha: 1).cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width * 0.523
    }
    
    func configureCell(fromHour hour: Hour) {
        timeLabel.text = hour.hourTs.toTime()
        tempLabel.text = "\(hour.temp)"
//        if let icon = hour.icon {
//            weatherImage.downloadedFrom(link: "https://yastatic.net/weather/i/icons/funky/dark/\(icon).svg")
//        }
        
        switch hour.condition {

        case "clear":
            weatherImage.image = UIImage(named: "sun")
        case "overcast":
            weatherImage.image = UIImage(named: "darkCloud")
        case "cloudy":
            weatherImage.image = UIImage(named: "cloud")
        case "partly-cloudy-and-rain":
            weatherImage.image = UIImage(named: "cloudRain")
        case "overcast-thunderstorms-with-rain":
            weatherImage.image = UIImage(named: "rainThunder")
        case "wet-snow":
            weatherImage.image = UIImage(named: "rain")
        case "partly-cloudy-and-snow":
            weatherImage.image = UIImage(named: "darkCloud")
        case "partly-cloudy":
            weatherImage.image = UIImage(named: "cloud")
        case "partly-cloudy-and-light-rain":
            weatherImage.image = UIImage(named: "cloudRain")
        case "overcast-and-rain":
            weatherImage.image = UIImage(named: "cloudRain")
        case "cloudy-and-light-rain":
            weatherImage.image = UIImage(named: "cloudRain")
        case "overcast-and-light-rain":
            weatherImage.image = UIImage(named: "rain")
        case "cloudy-and-rain":
            weatherImage.image = UIImage(named: "cloud")
        case "light-snow":
            weatherImage.image = UIImage(named: "rain")
        case "partly-cloudy-and-light-snow":
            weatherImage.image = UIImage(named: "darkCloud")
        case "overcast-and-light-snow":
            weatherImage.image = UIImage(named: "darkCloud")
        case "overcast-and-snow":
            weatherImage.image = UIImage(named: "darkCloud")
        case "cloudy-and-snow":
            weatherImage.image = UIImage(named: "darkCloud")

        default: break
        }
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        timeLabel.text = nil
//        tempLabel.text = nil
//        weatherImage.image = nil
//    }
}

extension MainCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            timeLabel.heightAnchor.constraint(equalTo: timeLabel.widthAnchor, multiplier: 0.5),
            
            weatherImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            weatherImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weatherImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.28),
            weatherImage.heightAnchor.constraint(equalTo: weatherImage.widthAnchor),
            
            tempLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 4),
            tempLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tempLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.57142),
            //tempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
}
