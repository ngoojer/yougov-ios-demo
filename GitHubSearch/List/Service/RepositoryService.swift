import Foundation
import Combine

protocol RepositoryServiceProtocol {
    var networkService: NetworkServiceProtocol { get }
    func searchRepository(query: String) -> AnyPublisher<Response, Error>
}

struct RepositoryService: RepositoryServiceProtocol {
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func searchRepository(query: String) -> AnyPublisher<Response, Error> {
        let endpoint = Endpoint.searchRepository(query: query)
        return networkService
            .get(type: Response.self, url: endpoint.url, header: nil)
    }

}
