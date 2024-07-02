//
//  CarModel.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import Foundation

struct CarModel: Equatable {
    
    // MARK: - Properties
    
    let name: String
    
    // MARK: - Initializers
    
    init(name: String) {
        self.name = name
    }
    
    init?(name: String?) {
        guard let name else { return nil }
        
        self.init(name: name)
    }
}
