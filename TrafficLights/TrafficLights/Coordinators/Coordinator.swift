//
//  Coordinator.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    var children: [Coordinator] { get set }
    
    func start()
    func addCoordinator(_ coordinator: Coordinator)
    func onComplete()
}

extension Coordinator {
    
    func addCoordinator(_ coordinator: Coordinator) {
        coordinator.parent = self
        self.children.append(coordinator)
        coordinator.start()
    }
    
    func onComplete() {
        self.parent?.children.removeAll(where: { $0 === self })
        self.parent = nil
    }
}
