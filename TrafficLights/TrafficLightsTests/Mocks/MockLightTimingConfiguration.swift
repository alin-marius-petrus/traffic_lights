//
//  MockLightTimingConfiguration.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

import Foundation
@testable import TrafficLights

class MockLightTimingConfiguration: LightTimingConfiguration {
    
    var mockCallback: ((_ light: TrafficLight) -> Double)?
    
    func duration(forLight light: TrafficLight) -> Double {
        guard let result = self.mockCallback?(light) else { return 0.1 }
        
        return result
    }
    
}
