//
//  CarModelNameCountValidatorTests.swift
//  TrafficLightsTests
//
//  Created by Alin Petrus on 03.07.2024.
//

@testable import TrafficLights
import XCTest

// swiftlint:disable implicitly_unwrapped_optional
final class CarModelNameCountValidatorTests: XCTestCase {
    
    private var sut: CarModelNameCountValidator!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.sut = CarModelNameCountValidator(minCharacterCount: 2)
    }
    
    override func tearDownWithError() throws {
        self.sut = nil
        
        try super.tearDownWithError()
    }
    
    func testNilName() {
        XCTAssertFalse(self.sut.isValidName(nil))
    }
    
    func testEmptyName() {
        XCTAssertFalse(self.sut.isValidName(""))
    }
    
    func testOneCharacterName() {
        XCTAssertFalse(self.sut.isValidName("O"))
    }
    
    func testNewlineName() {
        XCTAssertFalse(self.sut.isValidName("\n"))
    }
    
    func testWhitespaceName() {
        XCTAssertFalse(self.sut.isValidName("   "))
    }
    
    func testNewlineAndWhitespaceName() {
        XCTAssertFalse(self.sut.isValidName(" \n "))
    }
    
    func testCharacterAndWhitespaceAndNewlineName() {
        XCTAssertFalse(self.sut.isValidName(" O\n "))
    }
    
    func testValidName() {
        XCTAssertTrue(self.sut.isValidName("On"))
    }
    
    func testDefaultValidator() {
        let validator = CarModelNameCountValidator()
        
        XCTAssertFalse(validator.isValidName("On"))
        XCTAssertTrue(validator.isValidName("Off"))
    }
    
}
// swiftlint:enable implicitly_unwrapped_optional
