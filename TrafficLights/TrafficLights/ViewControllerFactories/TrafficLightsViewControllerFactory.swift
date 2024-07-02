//
//  TrafficLightsViewControllerFactory.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import UIKit

protocol TrafficLightsViewControllerFactory {
    func viewController(forRoute route: TrafficRoute,
                        withCoordinator coordinator: TrafficLightsCoordinator) -> UIViewController
}
