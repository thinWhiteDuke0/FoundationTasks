@testable import UnitTesting
import XCTest

final class APIServiceTests: XCTestCase {
    private var sut: APIService!

    override func setUp() {
        super.setUp()
        sut = APIService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // assert that correct result is returned
    func test_apiService_whenSuccess_shouldReturnDecodedUsers() async {
        let url = "https://jsonplaceholder.typicode.com/users"
        let result = await sut.fetchUsersAsync(urlString: url)

        switch result {
        case .success(let users):
            XCTAssertFalse(users.isEmpty)
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }

    // assert that failure is returned when url is invalid
    func test_apiService_whenInvalidUrl_shouldReturnFailure() async {
        let result = await sut.fetchUsersAsync(urlString: "")
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertEqual(error, .unexpected)
        }
    }
}
