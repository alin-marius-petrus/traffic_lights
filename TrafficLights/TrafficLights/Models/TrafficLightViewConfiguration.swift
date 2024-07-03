//
//  TrafficLightViewConfiguration.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import UIKit

struct TrafficLightViewConfiguration: Equatable {
    let color: UIColor
    let activeColor: UIColor
    var isActive: Bool
    
    var currentColor: UIColor {
        if self.isActive {
            return self.activeColor
        } else {
            return self.color
        }
    }
}
