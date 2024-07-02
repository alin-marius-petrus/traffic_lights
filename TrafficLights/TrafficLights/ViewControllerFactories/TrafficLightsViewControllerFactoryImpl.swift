//
//  TrafficLightsViewControllerFactoryImpl.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import UIKit

final class TrafficLightsViewControllerFactoryImpl: TrafficLightsViewControllerFactory {
    
    func viewController(forRoute route: TrafficRoute,
                        withCoordinator coordinator: TrafficLightsCoordinator) -> UIViewController {
        switch route {
        case .carModel:
            let viewModel = CarDetailViewModel(router: coordinator)
            
            return CarModelViewController(viewModel: viewModel)
        case .semaphore(let model):
            let viewModel = SemaphoreViewModel(carModel: model)
            
            return SemaphoreViewController(viewModel: viewModel)
        }
    }
    
}
