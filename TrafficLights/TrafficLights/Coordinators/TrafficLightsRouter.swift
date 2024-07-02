//
//  TrafficLightsRouter.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import Foundation

protocol TrafficLightsRouter: AnyObject {
    
    func onStartDriving(withCarModel carModel: CarModel)
    
}
