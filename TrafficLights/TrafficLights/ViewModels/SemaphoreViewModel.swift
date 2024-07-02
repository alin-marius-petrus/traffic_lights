//
//  SemaphoreViewModel.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import Foundation

@MainActor
final class SemaphoreViewModel {
    
    // MARK: - Properties
    
    private let carModel: CarModel
    private let state: TrafficLightState
    @Published private(set) var currentLight: TrafficLight
    private var task: Task<(), Never>?
    
    var title: String {
        self.carModel.name
    }
    
    var redLightConfiguration: TrafficLightViewConfiguration {
        TrafficLightViewConfiguration(color: .red.darkerVariant,
                                      activeColor: .red,
                                      isActive: self.currentLight == .red)
    }
    
    var orangeLightConfiguration: TrafficLightViewConfiguration {
        TrafficLightViewConfiguration(color: .orange.darkerVariant,
                                      activeColor: .orange,
                                      isActive: self.currentLight == .orange)
    }
    
    var greenLightConfiguration: TrafficLightViewConfiguration {
        TrafficLightViewConfiguration(color: .green.darkerVariant,
                                      activeColor: .green,
                                      isActive: self.currentLight == .green)
    }
    
    // MARK: - Initializer
    
    init(carModel: CarModel,
         state: TrafficLightState = TrafficLightState()) {
        self.carModel = carModel
        self.state = state
        self.currentLight = state.currentLight
    }
    
    // MARK: - Public functions
    
    func startSemaphore() {
        guard self.task == nil else { return }
        
        self.task = Task {
            for await light in self.state {
                self.currentLight = light
            }
        }
    }
    
    func invalidate() {
        self.task?.cancel()
        self.task = nil
    }
    
}
