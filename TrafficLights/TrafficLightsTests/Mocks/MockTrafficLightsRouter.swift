//
//  MockTrafficLightsRouter.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

import Foundation
@testable import TrafficLights

class MockTrafficLightsRouter: TrafficLightsRouter {
    
    var onStartDrivingBlock: ((_ carModel: CarModel) -> Void)?
    
    func onStartDriving(withCarModel carModel: CarModel) {
        self.onStartDrivingBlock?(carModel)
    }
    
}
