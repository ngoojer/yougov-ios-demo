import Foundation
import UIKit
import Combine

class DetailViewModel: ObservableObject {
    @Published public var avatar = UIImage()
    private let repo: Repository
    private var cancellable: AnyCancellable?
    
    public init(repo: Repository) {
        self.repo = repo
    }
    
    public var ownerName: String {
        repo.owner.login
    }
    
    public var creationTime: String {
        guard let strDate = repo.createdAt,
              let date = DetailViewModel.dateFormatterServer
                .date(from: strDate) else {fatalError("invalid date")}
        return DetailViewModel.dateFormatterLocal.string(from: date)
    }
    
    public var name: String {
        repo.name ?? "NA"
    }
    
    public var star: String {
        repo.starCount ?? "NA"
    }
    
    public var langage: String {
        repo.language ?? "NA"
    }
    
    public func onAppear() {
        loadAvatarImage()
    }
    
    private func loadAvatarImage(){
        guard let strUrl = repo.owner.avatarUrl,
              let url = URL(string: strUrl) else { return }
        cancellable = ImageLoader.shared.loadImage(from: url)
            .sink(receiveValue: { [weak self](image) in
                if let image = image {
                    self?.avatar = image
                }
            })
    }
}

extension DetailViewModel {
    private static let dateFormatterServer: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    
    private static let dateFormatterLocal: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy hh:mm a"
        formatter.timeZone =  TimeZone.current
        return formatter
    }()
    
}
