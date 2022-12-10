//
//  MainTableViewCell.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 07.12.2022.
//

import UIKit

class MainForecastCollectionViewCell: UICollectionViewCell {
    
    private lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: "17/04", attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.13
        label.attributedText = NSMutableAttributedString(string: "57%", attributes: [NSAttributedString.Key.kern: -0.12, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private lazy var weatherImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "rain")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(red: 0.154, green: 0.152, blue: 0.135, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.05
        label.attributedText = NSMutableAttributedString(string: "Преимущес...облачно", attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private lazy var minMaxLabel: UILabel = {
        let label = UILabel()
         label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font = UIFont(name: "Rubik-Regular", size: 18)
         var paragraphStyle = NSMutableParagraphStyle()
         paragraphStyle.lineHeightMultiple = 1.08
         label.attributedText = NSMutableAttributedString(string: "4 -11", attributes: [NSAttributedString.Key.kern: 0.16, NSAttributedString.Key.paragraphStyle: paragraphStyle])
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
        self.addSubview(dateLabel)
        self.addSubview(percentLabel)
        self.addSubview(weatherImage)
        self.addSubview(descriptionLabel)
        self.addSubview(minMaxLabel)
        
        self.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height * 0.0892
    }
    
}

extension MainForecastCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            dateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.154069),
            dateLabel.heightAnchor.constraint(equalTo: dateLabel.widthAnchor, multiplier: 0.358),
            
            weatherImage.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            weatherImage.topAnchor.constraint(equalTo: self.centerYAnchor),
            weatherImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.04),
            weatherImage.heightAnchor.constraint(equalTo: weatherImage.widthAnchor, multiplier: 1.1333),
            
            percentLabel.centerYAnchor.constraint(equalTo: weatherImage.centerYAnchor),
            percentLabel.leadingAnchor.constraint(equalTo: weatherImage.trailingAnchor, constant: 6),
            percentLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.09686),
            percentLabel.heightAnchor.constraint(equalTo: weatherImage.widthAnchor, multiplier: 1.3004),
            
            descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: percentLabel.trailingAnchor, constant: 3),
            descriptionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5988),
            descriptionLabel.heightAnchor.constraint(equalTo: descriptionLabel.widthAnchor, multiplier: 0.09223),
            
            minMaxLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            minMaxLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -26),
            minMaxLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.125),
            minMaxLabel.heightAnchor.constraint(equalTo: minMaxLabel.widthAnchor, multiplier: 0.507)
            
        ])
    }
}
