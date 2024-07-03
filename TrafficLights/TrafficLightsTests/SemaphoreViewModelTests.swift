//
//  SemaphoreViewModelTests.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

import Combine
@testable import TrafficLights
import XCTest

// swiftlint:disable implicitly_unwrapped_optional
@MainActor
final class SemaphoreViewModelTests: XCTestCase {
    private var disposables: Set<AnyCancellable>!
    private var model: CarModel!
    private var configuration: MockLightTimingConfiguration!
    private var state: TrafficLightState!
    private var sut: SemaphoreViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.disposables = Set()
        self.model = CarModel(name: "N7")
        self.configuration = MockLightTimingConfiguration()
        self.state = TrafficLightState(timingConfiguration: self.configuration)
        self.sut = SemaphoreViewModel(carModel: self.model, state: self.state)
    }

    override func tearDownWithError() throws {
        self.disposables = nil
        self.model = nil
        self.configuration = nil
        self.state = nil
        self.sut = nil
        
        try super.tearDownWithError()
    }

    func testCurrentLight() {
        XCTAssertEqual(self.sut.currentLight, self.state.currentLight)
    }
    
    func testTitle() {
        XCTAssertEqual(self.sut.title, self.model.name)
    }
    
    func testRedLightConfiguration() {
        let expected = TrafficLightViewConfiguration(color: .red.darkerVariant,
                                                     activeColor: .red,
                                                     isActive: self.state.currentLight == .red)
        
        XCTAssertEqual(expected, self.sut.redLightConfiguration)
    }
    
    func testOrangeLightConfiguration() {
        let expected = TrafficLightViewConfiguration(color: .orange.darkerVariant,
                                                     activeColor: .orange,
                                                     isActive: self.state.currentLight == .orange)
        
        XCTAssertEqual(expected, self.sut.orangeLightConfiguration)
    }
    
    func testGreenLightConfiguration() {
        let expected = TrafficLightViewConfiguration(color: .green.darkerVariant,
                                                     activeColor: .green,
                                                     isActive: self.state.currentLight == .green)
        
        XCTAssertEqual(expected, self.sut.greenLightConfiguration)
    }
    
    func testSemaphoreNotStarted() async {
        let expected = expectation(description: "Current light does not change")
        expected.fulfill()
        
        self.sut.$currentLight
            .sink { newValue in
                if newValue != self.state.currentLight {
                    expected.fulfill()
                }
            }
            .store(in: &self.disposables)
        
        await fulfillment(of: [expected], timeout: 0.5)
    }
    
    func testSemaphoreStarted() async {
        let expected = expectation(description: "Current light changes")
        
        let expectedLights: [TrafficLight] = [.red, .orange, .green, .orange, .red]
        var currentLights: [TrafficLight] = []
        
        self.sut.$currentLight
            .sink { newValue in
                currentLights.append(newValue)
                
                if expectedLights == currentLights {
                    expected.fulfill()
                }
            }
            .store(in: &self.disposables)
        
        self.sut.startSemaphore()
        
        await fulfillment(of: [expected], timeout: 0.5)
    }
    
    func testSemaphoreInvalidated() async {
        let unexpected = expectation(description: "Current light does not change anymore")
        unexpected.isInverted = true
        
        let expectedLights: [TrafficLight] = [.red, .orange, .green, .orange, .red]
        var currentLights: [TrafficLight] = []
        
        self.sut.$currentLight
            .sink { newValue in
                currentLights.append(newValue)
                
                if expectedLights == currentLights {
                    self.sut.invalidate()
                }
                
                if currentLights.count > expectedLights.count {
                    unexpected.fulfill()
                }
            }
            .store(in: &self.disposables)
        
        self.sut.startSemaphore()
        
        await fulfillment(of: [unexpected], timeout: 1.0)
    }

}
// swiftlint:enable implicitly_unwrapped_optional
