//
//  TrafficLightTests.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

@testable import TrafficLights
import XCTest

final class TrafficLightTests: XCTestCase {

    func testAllCases() {
        let actual = Set(TrafficLight.allCases)
        let expected = Set([TrafficLight.red, TrafficLight.green, TrafficLight.orange])
        
        XCTAssertEqual(actual.symmetricDifference(expected).isEmpty, true)
    }

}
