//
//  TrafficLight.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import Foundation

enum TrafficLight: Equatable, CaseIterable {
    case red
    case orange
    case green
}

extension TrafficLight {
    
    var duration: UInt {
        switch self {
        case .red:
            return 4
        case .green:
            return 4
        case .orange:
            return 1
        }
    }
    
}
