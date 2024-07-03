//
//  TrafficLightStateTests.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

@testable import TrafficLights
import XCTest

// swiftlint:disable implicitly_unwrapped_optional
final class TrafficLightStateTests: XCTestCase {
    private var mockConfiguration: MockLightTimingConfiguration!
    private var sut: TrafficLightState!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.mockConfiguration = MockLightTimingConfiguration()
        self.sut = TrafficLightState(timingConfiguration: self.mockConfiguration)
    }

    override func tearDownWithError() throws {
        self.mockConfiguration = nil
        self.sut = nil
        
        try super.tearDownWithError()
    }
    
    func testStartLight() {
        XCTAssertEqual(self.sut.currentLight, .red)
    }
    
    func testTargetLight() {
        XCTAssertEqual(self.sut.targetLight, .green)
    }
    
    func testSequence() async {
        let expected = expectation(description: "Correct sequence is generated")
        
        let expectedLights: [TrafficLight] = Array(repeating: [.red, .orange, .green, .orange],
                                             count: 3).flatMap { $0 }
        var actualLights: [TrafficLight] = [self.sut.currentLight]
        
        for await nextLight in self.sut {
            actualLights.append(nextLight)
            if actualLights.count == expectedLights.count {
                break
            }
        }
        
        if expectedLights == actualLights {
            expected.fulfill()
        }
        
        await fulfillment(of: [expected], timeout: 2)
    }
    
    func testRedDurationCallback() async {
        let expected = expectation(description: "Configuration is checked for the red light")
        
        let expectedLights: [TrafficLight] = [.red, .orange]
        var actualLights: [TrafficLight] = [self.sut.currentLight]
        
        self.mockConfiguration.mockCallback = { light in
            if light == .red {
                expected.fulfill()
                return 0.4
            }
            
            if light != .red {
                XCTFail("No check should be done for other colors")
            }
            
            return 0.1
        }
        
        for await nextLight in self.sut {
            actualLights.append(nextLight)
            if actualLights.count == expectedLights.count {
                break
            }
        }
        
        await fulfillment(of: [expected], timeout: 1)
    }
    
    func testOrangeDurationCallback() async {
        let redExpectation = expectation(description: "Configuration is checked for the red light")
        let orangeExpectation = expectation(description: "Configuration is checked for the orange light")
        
        let expectedLights: [TrafficLight] = [.red, .orange, .green]
        var actualLights: [TrafficLight] = [self.sut.currentLight]
        
        self.mockConfiguration.mockCallback = { light in
            if light == .red {
                redExpectation.fulfill()
                return 0.2
            }
            
            if light == .orange {
                orangeExpectation.fulfill()
                return 0.3
            }
            
            if light == .green {
                XCTFail("Green should not be checked")
            }
            
            return 0.1
        }
        
        for await nextLight in self.sut {
            actualLights.append(nextLight)
            if actualLights.count == expectedLights.count {
                break
            }
        }
        
        await fulfillment(of: [redExpectation, orangeExpectation], timeout: 1)
    }
    
    func testGreenDurationCallBack() async {
        let redExpectation = expectation(description: "Configuration is checked for the red light")
        let orangeExpectation = expectation(description: "Configuration is checked for the orange light")
        let greenExpectation = expectation(description: "Configuration is checked for the green light")
        
        let expectedLights: [TrafficLight] = [.red, .orange, .green, .orange]
        var actualLights: [TrafficLight] = [self.sut.currentLight]
        
        self.mockConfiguration.mockCallback = { light in
            if light == .red {
                redExpectation.fulfill()
                
                return 0.2
            }
            
            if light == .orange {
                orangeExpectation.fulfill()
                
                return 0.3
            }
            
            if light == .green {
                greenExpectation.fulfill()
                
                return 0.4
            }
            
            return 0.1
        }
        
        for await nextLight in self.sut {
            actualLights.append(nextLight)
            if actualLights.count == expectedLights.count {
                break
            }
        }
        
        await fulfillment(of: [redExpectation, orangeExpectation, greenExpectation], timeout: 1)
    }

}
// swiftlint:enable implicitly_unwrapped_optional
