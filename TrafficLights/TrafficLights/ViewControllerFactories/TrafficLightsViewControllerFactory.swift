//
//  TrafficLightsViewControllerFactory.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import UIKit

@MainActor
protocol TrafficLightsViewControllerFactory {
    
    func viewController(forRoute route: TrafficRoute,
                        withRouter router: TrafficLightsRouter) -> UIViewController
    
}
