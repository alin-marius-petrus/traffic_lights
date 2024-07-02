//
//  TrafficLightsView.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import UIKit

final class TrafficLightsView: UIView {
    
    // MARK: - Properties
    
    private let redView: TrafficLightView
    private let orangeView: TrafficLightView
    private let greenView: TrafficLightView
    private let stackView: UIStackView
    
    // MARK: - Initializers
    
    init(redConfiguration: TrafficLightViewConfiguration,
         orangeConfiguration: TrafficLightViewConfiguration,
         greenConfiguration: TrafficLightViewConfiguration) {
        let redView = TrafficLightView(configuration: redConfiguration)
        let orangeView = TrafficLightView(configuration: orangeConfiguration)
        let greenView = TrafficLightView(configuration: greenConfiguration)
        self.redView = redView
        self.orangeView = orangeView
        self.greenView = greenView
        
        self.stackView = UIStackView(arrangedSubviews: [redView, orangeView, greenView])
        
        super.init(frame: .zero)
        
        self.stackView.axis = .vertical
        self.stackView.distribution = .fillEqually
        
        let spacing = 20.0
        self.stackView.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .black
        self.layer.cornerRadius = spacing
        self.addSubview(self.stackView)
        
        self.setupConstraints(withSpacing: spacing)
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
    
    func setActiveLight(_ light: TrafficLight) {
        self.redView.setActive(light == .red)
        self.orangeView.setActive(light == .orange)
        self.greenView.setActive(light == .green)
    }
    
}

private extension TrafficLightsView {
    
    func setupConstraints(withSpacing spacing: CGFloat) {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: spacing).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                constant: spacing).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                 constant: -spacing).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                               constant: -spacing).isActive = true
    }
    
}
