//
//  TrafficLightsTimingConfigurationTests.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

@testable import TrafficLights
import XCTest

final class TrafficLightsTimingConfigurationTests: XCTestCase {
    
    func testInitializer() {
        let sut = TrafficLightsTimingConfiguration(redDuration: 1,
                                                   orangeDuration: 2,
                                                   greenDuration: 3)
        
        XCTAssertEqual(sut.redDuration, 1)
        XCTAssertEqual(sut.orangeDuration, 2)
        XCTAssertEqual(sut.greenDuration, 3)
    }
    
    func testDefaultInitializer() {
        let sut = TrafficLightsTimingConfiguration()
        
        XCTAssertEqual(sut.redDuration, 4)
        XCTAssertEqual(sut.greenDuration, 4)
        XCTAssertEqual(sut.orangeDuration, 1)
    }
    
    func testRedDuration() {
        let sut = TrafficLightsTimingConfiguration()
        
        XCTAssertEqual(sut.duration(forLight: .red), 4)
    }
    
    func testGreenDuration() {
        let sut = TrafficLightsTimingConfiguration()
        
        XCTAssertEqual(sut.duration(forLight: .green), 4)
    }
    
    func testOrangeDuration() {
        let sut = TrafficLightsTimingConfiguration()
        
        XCTAssertEqual(sut.duration(forLight: .orange), 1)
    }
    
}
