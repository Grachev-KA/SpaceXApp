import Foundation

final class NetworkManager {
    private let rocketDecoder = JSONDecoder()
    private let launchDecoder = JSONDecoder()
    private let rocketDateFormatter = DateFormatter()
    private let launchDateFormatter = DateFormatter()
    
    init() {
        rocketDecoder.keyDecodingStrategy = .convertFromSnakeCase
        rocketDateFormatter.dateFormat = "yyyy-MM-dd"
        rocketDecoder.dateDecodingStrategy = .formatted(rocketDateFormatter)
    
        launchDecoder.keyDecodingStrategy = .convertFromSnakeCase
        launchDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        launchDecoder.dateDecodingStrategy = .formatted(launchDateFormatter)
    }
    
    enum Errors: Error {
        case invalidURL
    }
    
    private func getData<T: Decodable>(url: String, decoder: JSONDecoder, completionHandler: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        
        guard let request = URL(string: url) else {
            completionHandler(.failure(Errors.invalidURL))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let data = try decoder.decode(T.self, from: data)
                print(data)
                completionHandler(.success(data))
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
        getData(url: NetworkUrl.rockets, decoder: rocketDecoder, completionHandler: completionHandler)
    }
    
    func getLaunches(_ url: String, completionHandler: @escaping (Result<[Launch], Error>) -> Void) {
        getData(url: NetworkUrl.launches, decoder: launchDecoder, completionHandler: completionHandler)
    }
}
