//
//  LightTimingConfiguration.swift
//  TrafficLights
//
//  Created by Alin Petrus on 03.07.2024.
//

import Foundation

protocol LightTimingConfiguration {
    
    func duration(forLight light: TrafficLight) -> Double
    
}
