//
//  CarModelNameCountValidator.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import Foundation

struct CarModelNameCountValidator: CarModelNameValidator {
    
    // MARK: - Properties
    
    private let minCharacterCount: Int
    
    // MARK: - Initializer
    
    init(minCharacterCount: Int = 3) {
        self.minCharacterCount = minCharacterCount
    }
    
    // MARK: - Protocol Conformance
    
    func isValidName(_ name: String?) -> Bool {
        guard let name else { return false }
        
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        return trimmed.count >= self.minCharacterCount
    }
    
}
