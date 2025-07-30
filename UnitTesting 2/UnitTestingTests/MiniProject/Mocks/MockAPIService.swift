@testable import UnitTesting

final class MockAPIService: APIServiceProtocol {
    var fetchUsersResult: Result<[User], APIError>?

    private(set) var fetchUsersCallsCount = 0
    private(set) var receivedUrl: String?

    func fetchUsers(
        urlString: String,
        completion: @escaping (Result<[User], APIError>) -> Void
    ) {
        fetchUsersCallsCount += 1
        receivedUrl = urlString
        if let fetchUsersResult {
            completion(fetchUsersResult)
        } else {
            completion(.failure(.unexpected))
        }
    }

    func fetchUsersAsync(urlString: String) async -> Result<[User], APIError> {
        .failure(.unexpected)
    }
}
