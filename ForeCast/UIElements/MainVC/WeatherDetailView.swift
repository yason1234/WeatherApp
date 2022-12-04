//
//  WeatherDetailView.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 02.12.2022.
//

import UIKit

final class WeatherDetailView: UIView {
    
    private lazy var cloudImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cloudLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private lazy var windImage: UIImageView = {
        let imageView = UIImageView()
         imageView.image = UIImage(named: "wind")
         imageView.contentMode = .scaleAspectFit
         imageView.clipsToBounds = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.text = "3 m/s"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private lazy var rainImage: UIImageView = {
        let imageView = UIImageView()
         imageView.image = UIImage(named: "rain")
         imageView.contentMode = .scaleAspectFit
         imageView.clipsToBounds = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
    }()
    
    private lazy var rainLabel: UILabel = {
        let label = UILabel()
        label.text = "75%"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(cloudImage)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cloudLabel)
        self.addSubview(windImage)
        self.addSubview(windLabel)
        self.addSubview(rainImage)
        self.addSubview(rainLabel)
    }
}

extension WeatherDetailView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cloudImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cloudImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            cloudImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            cloudImage.widthAnchor.constraint(equalTo: cloudImage.heightAnchor, multiplier: 1.16),

            cloudLabel.centerYAnchor.constraint(equalTo: cloudImage.centerYAnchor),
            cloudLabel.leadingAnchor.constraint(equalTo: cloudImage.trailingAnchor, constant: 5.4),
            cloudLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05),
            cloudLabel.heightAnchor.constraint(equalTo: cloudImage.heightAnchor),
            
            windImage.leadingAnchor.constraint(equalTo: cloudLabel.trailingAnchor, constant: 19),
            windImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            windImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            windImage.widthAnchor.constraint(equalTo: windImage.heightAnchor, multiplier: 1.56),
            
            windLabel.centerYAnchor.constraint(equalTo: windImage.centerYAnchor),
            windLabel.leadingAnchor.constraint(equalTo: windImage.trailingAnchor, constant: 5),
            windLabel.heightAnchor.constraint(equalTo: cloudLabel.heightAnchor),
            windLabel.widthAnchor.constraint(equalTo: windLabel.heightAnchor, multiplier: 2),
            
            rainImage.leadingAnchor.constraint(equalTo: windLabel.trailingAnchor, constant: 19),
            rainImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            rainImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7),
            rainImage.widthAnchor.constraint(equalTo: rainImage.heightAnchor, multiplier: 0.866),
            
            rainLabel.centerYAnchor.constraint(equalTo: windImage.centerYAnchor),
            rainLabel.leadingAnchor.constraint(equalTo: rainImage.trailingAnchor, constant: 5),
            rainLabel.heightAnchor.constraint(equalTo: cloudImage.heightAnchor),
            rainLabel.widthAnchor.constraint(equalTo: rainLabel.heightAnchor, multiplier: 1.55),
            
        ])
    }
}
