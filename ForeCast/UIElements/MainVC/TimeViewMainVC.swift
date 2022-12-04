//
//  TimeViewMainVC.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 02.12.2022.
//

import UIKit

final class TimeViewMainVC: UIView {
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.965, green: 0.867, blue: 0.004, alpha: 1)
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "17:48,  пт 16 апреля"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timeLabel)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
