import Foundation
import Combine

class RepositoryListViewModel: ObservableObject {
    @Published public var searchText = ""
    @Published public var repositories: [Repository] = []
    
    private var searchCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    private var repositoryService: RepositoryServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repositoryService: RepositoryServiceProtocol = RepositoryService()) {
        self.repositoryService = repositoryService
        _ = NetworkMonitor.shared
        bindSearch()
    }
    
    private func bindSearch() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap{ $0 }
            .sink { (str) in
                let text = str.trimmingCharacters(in:.whitespacesAndNewlines)
                guard text.count > 0 else{
                    return
                }
                self.fetchData(string: text)
            }.store(in: &cancellables)
    }
    
    public func onAppear() {
        self.fetchData(string: "yougov ios demo")
    }
    
    private func fetchData(string: String) {
        repositoryService.searchRepository(query: string)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self.repositories = []
                case .finished: break
                }
            } receiveValue: { [weak self] repo in
                self?.repositories = repo.items
                print("Total count = \(repo.totalCount)")
                print("Result count = \(repo.items.count)")
            }
            .store(in: &cancellables)
    }
}
