//
//  TrafficLightState.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import Foundation

struct TrafficLightState: AsyncSequence, AsyncIteratorProtocol {
    typealias AsyncIterator = TrafficLightState
    typealias Element = TrafficLight
    
    // MARK: - Properties
    
    private(set) var currentLight: TrafficLight
    private(set) var targetLight: TrafficLight
    private let timingConfiguration: LightTimingConfiguration
    
    init(timingConfiguration: LightTimingConfiguration = TrafficLightsTimingConfiguration()) {
        self.timingConfiguration = timingConfiguration
        self.currentLight = .red
        self.targetLight = .green
    }
    
    // MARK: - Protocol conformance
    
    mutating func next() async -> TrafficLight? {
        guard !Task.isCancelled else {
            return nil
        }
        
        let duration = self.timingConfiguration.duration(forLight: self.currentLight)
        
        try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
        
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
    
    func makeAsyncIterator() -> TrafficLightState {
        self
    }
    
}
