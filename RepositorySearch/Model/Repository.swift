import Foundation


struct GithubRepository: Codable {
    let totalCount: Int
    let repositories: [Repository]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case repositories = "items"
    }
}

struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String
    let owners: Owner
    let webUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case owners = "owner"
        case webUrl = "html_url"
    }
}

struct Owner: Codable {
    let avatar_url: String
    private enum CodingKeys: String, CodingKey {
        case avatar_url = "avatar_url"
    }
}
