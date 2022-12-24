//
//  ForecastTemp.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 04.12.2022.
//

import UIKit

final class ForecastTemp: UIView {
    
    private lazy var label: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "7/13"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gradus1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gradus")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var gradus2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gradus")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(day: Day) {
        label.text = "\(day.tempMin)/\(day.tempMax)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        self.addSubview(gradus1)
        self.addSubview(gradus2)
    }
}

extension ForecastTemp {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            gradus1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            gradus1.topAnchor.constraint(equalTo: self.topAnchor),
            gradus1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.068),
            gradus1.heightAnchor.constraint(equalTo: gradus1.widthAnchor),
        ])
    }
}
