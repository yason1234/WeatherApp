//
//  TextView.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 02.12.2022.
//

import UIKit

class CustomTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        self.textAlignment = .center
    }
}
