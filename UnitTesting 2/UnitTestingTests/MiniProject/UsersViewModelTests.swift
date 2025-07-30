//
//  UsersViewModelTests.swift
//  UnitTesting
//

@testable import UnitTesting
import XCTest

final class UsersViewModelTests: XCTestCase {
    var mockService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
    }

    override func tearDown() {
        mockService = nil
        super.tearDown()
    }

    // ✅ Test that fetchUsers calls the API service
    func test_viewModel_whenFetchUsers_callsApiService() {
        let sut = makeSut()
        sut.fetchUsers {}
        XCTAssertEqual(mockService.fetchUsersCallsCount, 1)
    }

    // ✅ Test that fetchUsers passes correct URL
    func test_viewModel_whenFetchUsers_passesCorrectUrlToApiService() {
        let sut = makeSut()
        var capturedUrl: String?

        mockService = MockAPIService()
        mockService.fetchUsersResult = .success([])

        let spyService = MockAPIService()
        spyService.fetchUsersResult = .success([])

        spyService.fetchUsers = { urlString, completion in
            capturedUrl = urlString
            completion(.success([]))
        }

        let viewModel = UsersViewModel(apiService: spyService)
        viewModel.fetchUsers {}

        XCTAssertEqual(capturedUrl, "https://jsonplaceholder.typicode.com/users")
    }

    // ✅ Test that users array is updated on success
    func test_viewModel_fetchUsers_whenSuccess_updatesUsers() {
        let expectedUser = User(id: 1, name: "name", username: "surname", email: "user@email.com")
        mockService.fetchUsersResult = .success([expectedUser])
        let sut = makeSut()

        let expectation = self.expectation(description: "Fetch users")

        sut.fetchUsers {
            XCTAssertEqual(sut.users.count, 1)
            XCTAssertEqual(sut.users.first?.id, expectedUser.id)
            XCTAssertNil(sut.errorMessage)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    // ✅ Test that error message is updated when URL is invalid
    func test_viewModel_fetchUsers_whenInvalidUrl_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.unexpected)
        let sut = makeSut()

        let expectation = self.expectation(description: "Error message updated")

        sut.fetchUsers {
            XCTAssertEqual(sut.errorMessage, "Unexpected error")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    // ✅ Test for unexpected failure case
    func test_viewModel_fetchUsers_whenUnexectedFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.unexpected)
        let sut = makeSut()

        let expectation = self.expectation(description: "Unexpected error")

        sut.fetchUsers {
            XCTAssertEqual(sut.errorMessage, "Unexpected error")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    // ✅ Test for parsing failure
    func test_viewModel_fetchUsers_whenParsingFailure_updatesErrorMessage() {
        mockService.fetchUsersResult = .failure(.parsing)
        let sut = makeSut()

        let expectation = self.expectation(description: "Parsing error")

        sut.fetchUsers {
            XCTAssertEqual(sut.errorMessage, "Error parsing JSON")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    // ✅ Test clear() resets users
    func test_viewModel_clearUsers() {
        mockService.fetchUsersResult = .success([
            User(id: 1, name: "A", username: "B", email: "C")
        ])
        let sut = makeSut()

        let expectation = self.expectation(description: "Fetch users")

        sut.fetchUsers {
            sut.clear()
            XCTAssertTrue(sut.users.isEmpty)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    private func makeSut() -> UsersViewModel {
        UsersViewModel(apiService: mockService)
    }
}
