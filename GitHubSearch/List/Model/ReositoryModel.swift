import Foundation

struct Response: Codable {
    let totalCount: Int
    let items: [Repository]
}

struct Repository: Codable, Identifiable {
    var id, stargazersCount: Int
    let name, fullName, language, createdAt: String?
    let owner: User
    var starCount: String? {
        String(stargazersCount) 
    }
}

struct User: Codable, Identifiable {
    var id: Int
    var login: String
    var avatarUrl: String?
}
