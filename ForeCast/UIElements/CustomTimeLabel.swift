//
//  CustomTimeLabel.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 02.12.2022.
//

import UIKit

class CustomTimeLabel: UILabel {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        textColor = .white
        font = .systemFont(ofSize: 14, weight: .medium)
    }
}
