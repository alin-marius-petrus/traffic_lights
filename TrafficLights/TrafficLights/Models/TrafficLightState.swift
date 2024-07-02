//
//  TrafficLightState.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import Foundation

final class TrafficLightState: IteratorProtocol {
    private(set) var currentLight: TrafficLight
    private(set) var targetLight: TrafficLight
    
    init(currentLight: TrafficLight = .red,
         targetLight: TrafficLight = .green) {
        self.currentLight = currentLight
        self.targetLight = targetLight
    }
    
    func next() -> TrafficLight? {
        switch self.currentLight {
        case .red, .green:
            self.currentLight = .orange
        case .orange:
            if self.targetLight == .red {
                self.targetLight = .green
                self.currentLight = .red
            } else if self.targetLight == .green {
                self.targetLight = .red
                self.currentLight = .green
            } else {
                self.targetLight = .red
                self.currentLight = .green
            }
        }
        
        return self.currentLight
    }
}
