//
//  CarModelTests.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

@testable import TrafficLights
import XCTest

final class CarModelTests: XCTestCase {

    func testInit() {
        let sut = CarModel(name: "Dacia")
        
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.name, "Dacia")
    }
    
    func testFailableInit() {
        let sut = CarModel(name: nil)
        
        XCTAssertNil(sut)
    }

}
