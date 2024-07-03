//
//  CarDetailViewModelTests.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

import Combine
@testable import TrafficLights
import XCTest

// swiftlint:disable implicitly_unwrapped_optional
@MainActor
final class CarDetailViewModelTests: XCTestCase {

    private var disposables: Set<AnyCancellable>!
    private var mockValidator: MockCarModelNameValidator!
    private var mockRouter: MockTrafficLightsRouter!
    private var sut: CarDetailViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.disposables = Set()
        self.mockValidator = MockCarModelNameValidator()
        self.mockRouter = MockTrafficLightsRouter()
        self.sut = CarDetailViewModel(router: self.mockRouter,
                                      validator: self.mockValidator)
    }

    override func tearDownWithError() throws {
        self.disposables = nil
        self.mockRouter = nil
        self.mockValidator = nil
        self.sut = nil
        
        try super.tearDownWithError()
    }
    
    func testInitialState() {
        XCTAssertEqual(self.sut.state, .invalid)
    }
    
    func testInvalidState() {
        let invalid = CarDetailViewModel.State.invalid
        
        XCTAssertEqual(invalid, CarDetailViewModel.State.invalid)
        XCTAssertEqual(invalid.isValid, false)
        XCTAssertNotEqual(invalid, .valid(CarModel(name: "1")))
    }
    
    func testValidState() {
        let carModel = CarModel(name: "N7")
        let otherModel = CarModel(name: "N13")
        let valid = CarDetailViewModel.State.valid(carModel)
        
        XCTAssertEqual(valid, CarDetailViewModel.State.valid(carModel))
        XCTAssertEqual(valid.isValid, true)
        XCTAssertNotEqual(valid, .invalid)
        XCTAssertNotEqual(valid, CarDetailViewModel.State.valid(otherModel))
    }
    
    func testStartDrivingDoesNotMakeCallToRouter() async {
        let expected = expectation(description: "Call to router is not made")
        expected.isInverted = true
        
        self.mockRouter.onStartDrivingBlock = { _ in
            expected.fulfill()
        }
        
        self.sut.onStartDriving()
        
        await fulfillment(of: [expected], timeout: 0.1)
    }
    
    func testUpdatingTheNameMakesCallToValidator() async {
        let expected = expectation(description: "Call to validator is made")
        
        self.mockValidator.isValidNameBlock = { name in
            XCTAssertEqual("NM", name)
            expected.fulfill()
            
            return false
        }
        
        self.sut.updateModelName("NM")
        
        await fulfillment(of: [expected], timeout: 0.1)
    }
    
    func testStateDoesNotTransitionToValid() async {
        let expected = expectation(description: "Does not transition to valid state")
        expected.isInverted = true
        
        self.mockValidator.isValidNameBlock = { _ in
            false
        }
        
        self.sut.$state
            .sink { newValue in
                if newValue.isValid {
                    expected.fulfill()
                }
            }
            .store(in: &self.disposables)
        
        self.sut.updateModelName("NM")
        
        await fulfillment(of: [expected], timeout: 0.1)
    }
    
    func testStateTransitionsToValid() async {
        let expected = expectation(description: "Transitions to valid state")
        
        self.mockValidator.isValidNameBlock = { _ in
            true
        }
        
        self.sut.$state
            .sink { newValue in
                if newValue.isValid {
                    expected.fulfill()
                }
            }
            .store(in: &self.disposables)
        
        self.sut.updateModelName("NM")
        
        await fulfillment(of: [expected], timeout: 0.1)
    }
    
    func testCallToRouterIsMade() async {
        let expected = expectation(description: "Call to router is made")
        
        self.mockValidator.isValidNameBlock = { _ in
            true
        }
        
        self.mockRouter.onStartDrivingBlock = { model in
            XCTAssertEqual(model.name, "NM")
            expected.fulfill()
        }
        
        self.sut.updateModelName("NM")
        
        self.sut.onStartDriving()
        
        await fulfillment(of: [expected], timeout: 0.1)
    }

}
// swiftlint:enable implicitly_unwrapped_optional
