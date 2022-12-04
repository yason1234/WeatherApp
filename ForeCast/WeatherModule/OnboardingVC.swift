//
//  OnboardingVC.swift
//  ForeCast
//
//  Created by Dima Shikhalev on 01.12.2022.
//

import UIKit

final class OnboardingVC: UIViewController {
    
    private lazy var umbrellaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "umbrella")
        return imageView
    }()
    
    private lazy var firstTextView: CustomTextView = {
       let textView = CustomTextView()
        textView.text = "Разрешить приложению  ForeCast использовать данные о местоположении вашего устройства"
        textView.font = .systemFont(ofSize: 21, weight: .semibold)
        textView.textColor = UIColor(red: 0.973, green: 0.961, blue: 0.961, alpha: 1)
        return textView
    }()
    
    private lazy var secondTextView: CustomTextView = {
        let textView = CustomTextView()
        textView.text = "Чтобы получить более точные прогнозы погоды во время движения или путешествия"
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.textColor = .white
        return textView
    }()
    
    private lazy var thirdTextView: CustomTextView = {
        let textView = CustomTextView()
        textView.text = "Вы можете изменить свой выбор в любое время из меню приложения"
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        textView.textColor = .white
        return textView
    }()
    
    private lazy var useLocationButton: CustomButton = {
       let button = CustomButton()
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ  УСТРОЙСТВА", for: .normal)
        return button
    }()
    
    private lazy var notAddButton: UIButton = {
        let button = UIButton()
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.textColor = UIColor(red: 0.992, green: 0.986, blue: 0.963, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        return button
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
        
        view.backgroundColor = Helper.shared.backColor
        setViews()
        setContraints()
    }
    
    private func setViews() {
        view.addSubview(umbrellaImageView)
        view.addSubview(firstTextView)
        view.addSubview(secondTextView)
        view.addSubview(thirdTextView)
        view.addSubview(useLocationButton)
        view.addSubview(notAddButton)
    }
}

extension OnboardingVC {
    
    private func setContraints() {
        NSLayoutConstraint.activate([
            umbrellaImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            umbrellaImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 148),
            umbrellaImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.24),
            umbrellaImageView.widthAnchor.constraint(equalTo: umbrellaImageView.heightAnchor, multiplier: 0.918),
            
            firstTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            firstTextView.topAnchor.constraint(equalTo: umbrellaImageView.bottomAnchor, constant: 60),
            firstTextView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.858),
            firstTextView.heightAnchor.constraint(equalTo: firstTextView.widthAnchor, multiplier: 0.195),
            
            secondTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            secondTextView.topAnchor.constraint(equalTo: firstTextView.bottomAnchor, constant: 56),
            secondTextView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.837),
            secondTextView.heightAnchor.constraint(equalTo: secondTextView.widthAnchor, multiplier: 0.15),
            
            thirdTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            thirdTextView.topAnchor.constraint(equalTo: secondTextView.bottomAnchor, constant: 14),
            thirdTextView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.837),
            thirdTextView.heightAnchor.constraint(equalTo: thirdTextView.widthAnchor, multiplier: 0.15),
            
            useLocationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            useLocationButton.topAnchor.constraint(equalTo: thirdTextView.bottomAnchor, constant: 57),
            useLocationButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.906),
            useLocationButton.heightAnchor.constraint(equalTo: useLocationButton.widthAnchor, multiplier: 0.117),
            
            notAddButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17),
            notAddButton.topAnchor.constraint(equalTo: useLocationButton.bottomAnchor, constant: 25),
            notAddButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.778),
        ])
    }
}
