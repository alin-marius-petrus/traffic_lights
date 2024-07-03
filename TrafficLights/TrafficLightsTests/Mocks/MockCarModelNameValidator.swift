//
//  MockCarModelNameValidator.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

import Foundation
@testable import TrafficLights

class MockCarModelNameValidator: CarModelNameValidator {
    
    var isValidNameBlock: ((_ name: String?) -> Bool)?
    
    func isValidName(_ name: String?) -> Bool {
        guard let result = self.isValidNameBlock?(name) else { return true }
        
        return result
    }
    
}
