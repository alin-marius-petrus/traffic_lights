//
//  TrafficLightsViewControllerFactoryImpl.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import UIKit

final class TrafficLightsViewControllerFactoryImpl: TrafficLightsViewControllerFactory {
    
    func viewController(forRoute route: TrafficRoute,
                        withRouter router: TrafficLightsRouter) -> UIViewController {
        switch route {
        case .carModel:
            let viewModel = CarDetailViewModel(router: router)
            
            return CarModelViewController(viewModel: viewModel)
        case .semaphore(let model):
            let viewModel = SemaphoreViewModel(carModel: model)
            
            return SemaphoreViewController(viewModel: viewModel)
        }
    }
    
}
