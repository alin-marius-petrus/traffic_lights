//
//  TrafficLightViewConfigurationTests.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

@testable import TrafficLights
import XCTest

// swiftlint:disable implicitly_unwrapped_optional
final class TrafficLightViewConfigurationTests: XCTestCase {
    
    private var sut: TrafficLightViewConfiguration!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.sut = TrafficLightViewConfiguration(color: .red,
                                                 activeColor: .systemPink,
                                                 isActive: false)
    }
    
    override func tearDownWithError() throws {
        self.sut = nil
        
        try super.tearDownWithError()
    }
    
    func testColor() {
        XCTAssertEqual(self.sut.color, .red)
    }
    
    func testActiveColor() {
        XCTAssertEqual(self.sut.activeColor, .systemPink)
    }
    
    func testActive() {
        XCTAssertEqual(self.sut.isActive, false)
    }
    
    func testChangeActive() {
        self.sut.isActive.toggle()
        
        XCTAssertEqual(self.sut.isActive, true)
    }
    
    func testNotActiveCurrentColor() {
        XCTAssertEqual(self.sut.currentColor, .red)
    }
    
    func testActiveCurrentColor() {
        self.sut.isActive.toggle()
        
        XCTAssertEqual(self.sut.currentColor, .systemPink)
    }
    
}
// swiftlint:enable implicitly_unwrapped_optional
