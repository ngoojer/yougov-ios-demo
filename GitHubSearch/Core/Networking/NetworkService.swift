import Foundation
import Combine

typealias Header = [String: Any]

protocol NetworkServiceProtocol {
    func get<T: Decodable>(type: T.Type, url: URL, header: Header?) -> AnyPublisher<T, Error>
}

struct NetworkService: NetworkServiceProtocol {
    
    func get<T>(type: T.Type, url: URL, header: Header?) -> AnyPublisher<T, Error> where T : Decodable {
        var urlRequest = URLRequest(url: url)
        guard NetworkManager.isNetworkAvailable else {
            return Fail(error: NetworkError.noIntenet)
                .eraseToAnyPublisher()
        }
        
        if let header = header {
            header.forEach { (key, value) in
                if let value = value as? String {
                    urlRequest.setValue(value, forHTTPHeaderField: key)
                }
            }
        }
        print("URL = \(url)")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in NetworkError.invalidRequest }
            .flatMap { data, response -> AnyPublisher<T, Error> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: NetworkError.invalidResponse)
                        .eraseToAnyPublisher()
                }
                
                guard 200..<300 ~= response.statusCode else {
                    return Fail(error: NetworkError.dataLoadingError(response.statusCode, data))
                        .eraseToAnyPublisher()
                }
                
                return Just(data)
                    .decode(type: T.self, decoder: decoder)
                    .mapError {_ in NetworkError.jsonDecodingError}
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
