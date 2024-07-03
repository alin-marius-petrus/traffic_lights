//
//  TrafficLightsTimingConfiguration.swift
//  TrafficLights
//
//  Created by Alin Petrus on 03.07.2024.
//

import Foundation

struct TrafficLightsTimingConfiguration: LightTimingConfiguration {
    
    // MARK: - Properties
    
    let redDuration: Double
    let orangeDuration: Double
    let greenDuration: Double
    
    // MARK: - Initializers
    
    init(redDuration: Double,
         orangeDuration: Double,
         greenDuration: Double) {
        self.redDuration = redDuration
        self.orangeDuration = orangeDuration
        self.greenDuration = greenDuration
    }
    
    init() {
        self.init(redDuration: 4,
                  orangeDuration: 1,
                  greenDuration: 4)
    }
    
    // MARK: - Public functions
    
    func duration(forLight light: TrafficLight) -> Double {
        switch light {
        case .red:
            return self.redDuration
        case .orange:
            return self.orangeDuration
        case .green:
            return self.greenDuration
        }
    }
    
}
