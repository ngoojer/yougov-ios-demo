import Foundation
import Combine
import UIKit

class CellViewModel: Identifiable, ObservableObject {
    
    @Published public var avatar = UIImage()
    @Published public var like = false
    
    private let repo: Repository
    private var cancellable: AnyCancellable?
    
    public init(repo: Repository) {
        self.repo = repo
        loadAvatarImage()
    }
    
    public var ownerName: String {
        repo.owner.login
    }
    
    public var creationTime: String {
        guard let strDate = repo.createdAt,
              let date = CellViewModel.dateFormatterServer
                .date(from: strDate) else {fatalError("invalid date")}
        return CellViewModel.dateFormatterLocal.string(from: date)
    }
    
    public var repoName: String {
        repo.name ?? "NA"
    }
    
    public var fullName: String {
        repo.fullName ?? "NA"
    }
    
    public var star: String {
        repo.starCount ?? "NA"
    }
    
    public var language: String {
        repo.language ?? "NA"
    }
    
    public var likeImageName: String {
        let name = like ? "like_fill" : "like"
        return name
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

extension CellViewModel {
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
