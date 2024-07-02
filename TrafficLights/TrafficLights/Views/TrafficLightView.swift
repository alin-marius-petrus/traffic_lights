//
//  TrafficLightView.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import UIKit

final class TrafficLightView: UIView {
    
    // MARK: - Properties
    
    private let colorView: UIView = UIView()
    private var configuration: TrafficLightViewConfiguration {
        didSet {
            self.refreshUI()
        }
    }
    
    // MARK: - Initializers
    
    init(configuration: TrafficLightViewConfiguration) {
        self.configuration = configuration
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.colorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.colorView)
        self.colorView.backgroundColor = self.configuration.currentColor
        
        self.setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(*, unavailable)
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    // MARK: - Public functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.colorView.layer.cornerRadius = self.colorView.bounds.width / 2
    }
    
    func setActive(_ active: Bool) {
        if self.configuration.isActive != active {
            self.configuration.isActive = active
        }
    }
    
}

private extension TrafficLightView {
    
    func setupConstraints() {
        self.colorView.widthAnchor.constraint(equalTo: self.colorView.heightAnchor,
                                              multiplier: 1.0).isActive = true
        self.colorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.colorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.colorView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        self.colorView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: 0.0).isActive = true
        self.colorView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 0.0).isActive = true
        self.colorView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 0.0).isActive = true
    }
    
    func refreshUI() {
        UIView.animate(withDuration: 0.3) {
            self.colorView.backgroundColor = self.configuration.currentColor
        }
    }
    
}
