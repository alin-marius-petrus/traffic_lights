//
//  TrafficLightsViewControllerFactoryImplTests.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

@testable import TrafficLights
import XCTest

// swiftlint:disable type_name
@MainActor
final class TrafficLightsViewControllerFactoryImplTests: XCTestCase {
    
    func testViewControllerForCarModel() {
        let sut = TrafficLightsViewControllerFactoryImpl()
        let viewController = sut.viewController(forRoute: .carModel,
                                                withRouter: MockTrafficLightsRouter())
        
        XCTAssertEqual(viewController is CarModelViewController, true)
    }
    
    func testViewControllerForSemaphore() {
        let sut = TrafficLightsViewControllerFactoryImpl()
        let viewController = sut.viewController(forRoute: .semaphore(CarModel(name: "N7")),
                                                withRouter: MockTrafficLightsRouter())
        
        XCTAssertEqual(viewController is SemaphoreViewController, true)
    }

}
// swiftlint:enable type_name
