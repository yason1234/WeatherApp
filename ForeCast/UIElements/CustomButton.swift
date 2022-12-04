//
//  CustomButton.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 02.12.2022.
//

import UIKit

class CustomButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        layer.backgroundColor = UIColor(red: 0.949, green: 0.431, blue: 0.067, alpha: 1).cgColor
        layer.cornerRadius = 10
        titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
    }
}
