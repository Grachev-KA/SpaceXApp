import Foundation

final class NetworkManager {
    private let decoder = JSONDecoder()
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    enum Errors: Error {
        case invalidURL
    }
    
    func getData<T: Decodable>(url: String, type: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        
        guard let request = URL(string: url) else {
            completionHandler(.failure(Errors.invalidURL))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let dataSpaceRockets = try self.decoder.decode(T.self, from: data)
                completionHandler(.success(dataSpaceRockets))
            } catch {
                completionHandler(.failure(error))
            }
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
        }.resume()
    }
    
    func getRockets(_ url: String, completionHandler: @escaping (Result<[Rocket], Error>) -> Void) {
        getData(url: NetworkURL.rockets, type: [Rocket].self, completionHandler: completionHandler)
    }
    
    func getLaunches(_ url: String, completionHandler: @escaping (Result<[Launch], Error>) -> Void) {
        getData(url: NetworkURL.launches, type: [Launch].self, completionHandler: completionHandler)
    }
}
