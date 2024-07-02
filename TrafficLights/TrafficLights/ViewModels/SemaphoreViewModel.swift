//
//  SemaphoreViewModel.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import Foundation

final class SemaphoreViewModel {
    private let carModel: CarModel
    
    init(carModel: CarModel) {
        self.carModel = carModel
    }
    
    var title: String {
        self.carModel.name
    }
}
