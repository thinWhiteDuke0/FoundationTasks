//
//  CalculatorTests.swift
//

import XCTest
@testable import UnitTesting

final class CalculatorTests: XCTestCase {
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    // Given two numbers, when multiplying, then the result is their product
    func test_multiplication() {
        let result = calculator.multiply(10, 20)
        XCTAssertEqual(200, result)
    }

    // Given a non-zero divisor, when dividing, then the result is the quotient
    func test_divideByNonZero() throws {
        let result = try calculator.divide(20, 5)
        XCTAssertEqual(result, 4)
    }

    // Given a zero divisor, when dividing, then it throws a .divisionByZero error
    func test_divideByZero_throwsError() {
        XCTAssertThrowsError(try calculator.divide(10, 0)) { error in
            XCTAssertEqual(error as? Calculator.CalculatorError, .divisionByZero)
        }
    }

    // Check 3 scenarios: < 10, 10, > 10
    func test_isGreaterThanTen() {
        XCTAssertFalse(calculator.isGreaterThanTen(5))
        XCTAssertFalse(calculator.isGreaterThanTen(10))
        XCTAssertTrue(calculator.isGreaterThanTen(15))
    }

    // Use XCTAssertNotNil and/or XCTAssertEqual
    func test_safeSquareRoot_whenPositiveNumber_returnsValue() {
        let result = calculator.safeSquareRoot(16)
        XCTAssertNotNil(result)
        XCTAssertEqual(result, 4)
    }

    // Use XCTAssertNil
    func test_safeSquareRoot_whenNegativeNumber_returnsNil() {
        let result = calculator.safeSquareRoot(-9)
        XCTAssertNil(result)
    }
}
