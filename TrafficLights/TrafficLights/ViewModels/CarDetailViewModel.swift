//
//  CarDetailViewModel.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import Foundation

@MainActor
final class CarDetailViewModel {
    
    enum State: Equatable {
        case invalid
        case valid(CarModel)
        
        var isValid: Bool {
            self != .invalid
        }
    }
    
    // MARK: - Properties
    
    private var carModelName: String? {
        didSet {
            if self.validator.isValidName(self.carModelName),
               let carModel = CarModel(name: self.carModelName) {
                self.state = .valid(carModel)
            } else {
                self.state = .invalid
            }
        }
    }
    
    private weak var router: TrafficLightsRouter?
    
    private var validator: CarModelNameValidator
    @Published private(set) var state: State = .invalid
    
    // MARK: - Initializer
    
    init(router: TrafficLightsRouter,
         validator: CarModelNameValidator = CarModelNameCountValidator()) {
        self.router = router
        self.validator = validator
    }
    
    // MARK: - Public
    
    func updateModelName(_ name: String?) {
        if self.carModelName != name {
            self.carModelName = name
        }
    }
    
    func onStartDriving() {
        if case let .valid(carModel) = self.state {
            self.router?.onStartDriving(withCarModel: carModel)
        }
    }
    
}
