//
//  TrafficLightsCoordinator.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import UIKit

@MainActor
final class TrafficLightsCoordinator: NSObject, Coordinator {
    
    // MARK: - Properties
    
    weak var parent: Coordinator?
    var children: [Coordinator] = []
    private var factory: TrafficLightsViewControllerFactory
    private var navigationPath: [TrafficRoute] = [.carModel]
    
    private weak var window: UIWindow?
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var navigationController: UINavigationController!
    
    // MARK: - Initializers
    
    init(window: UIWindow,
         factory: TrafficLightsViewControllerFactory) {
        self.window = window
        self.factory = factory
        
        super.init()
        
        let carModelVC = factory.viewController(forRoute: .carModel, withRouter: self)
        self.navigationController = UINavigationController(rootViewController: carModelVC)
        
        self.navigationController.delegate = self
    }
    
    // MARK: - Public functions
    
    func start() {
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func navigate(toRoute route: TrafficRoute) {
        if let index = self.navigationPath.firstIndex(of: route) {
            // visible, do nothing
            guard index != self.navigationPath.count - 1 else { return }
            
            // one or more pops
            let difference = self.navigationController.viewControllers.count - 1 - index
            self.navigationController.viewControllers.removeLast(difference)
            self.navigationPath.removeLast(difference)
        } else {
            let viewController = self.factory.viewController(forRoute: route, withRouter: self)
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
}

extension TrafficLightsCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, 
                              didShow viewController: UIViewController,
                              animated: Bool) {
        // handle popping
        if navigationController.viewControllers.count < self.navigationPath.count {
            self.navigationPath.removeLast(self.navigationPath.count - navigationController.viewControllers.count)
        }
    }
}

extension TrafficLightsCoordinator: TrafficLightsRouter {
    
    func onStartDriving(withCarModel carModel: CarModel) {
        self.navigate(toRoute: .semaphore(carModel))
    }
    
}
