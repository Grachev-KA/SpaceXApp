final class NetworkManagerMock: NetworkManagerProtocol {
    var rockets: [Rocket]?
    var rocketsError: Error?
    var launches: [Launch]?
    var launchesError: Error?
    
    func getRockets(completionHandler: @escaping (Result<[Rocket], Error>) -> Void) {
        if let rockets {
            completionHandler(.success(rockets))
        } else {
            completionHandler(.failure(rocketsError!))
        }
    }
    
    func getLaunches(completionHandler: @escaping (Result<[Launch], Error>) -> Void) {
        if let launches {
            completionHandler(.success(launches))
        } else {
            completionHandler(.failure(launchesError!))
        }
    }
}
