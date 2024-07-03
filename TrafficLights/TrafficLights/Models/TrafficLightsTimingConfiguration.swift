//
//  TrafficLightsTimingConfiguration.swift
//  TrafficLights
//
//  Created by Alin Petrus on 03.07.2024.
//

import Foundation

struct TrafficLightsTimingConfiguration {
    
    // MARK: - Properties
    
    let redDuration: Int
    let orangeDuration: Int
    let greenDuration: Int
    
    // MARK: - Initializers
    
    init(redDuration: Int, 
         orangeDuration: Int,
         greenDuration: Int) {
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
    
    func duration(forLight light: TrafficLight) -> Int {
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
