import Foundation

extension URL {
    static let searchRepositories: String = "https://api.github.com/search/repositories?"
}

enum HTTPMethod: String {
    case GET
    case POST
}

enum APIError: Error {
    case noData
    case invalidResponse
    case badRequest(String?)
    case serverError(String?)
    case parseError(String?)
    case unknown
}

enum APIResult {
    case success(GithubRepository)
    case failure(Error)
}

protocol Endpoint {
    var url: URL { get }
    var method: HTTPMethod { get }
    var query: String { get }
}

extension Endpoint {
    fileprivate var urlRequest: URLRequest {
        var req = URLRequest(url: url)
        req.httpMethod = method.rawValue
        return req
    }
}

class ServiceHandler: Endpoint {
    var url: URL
    var method: HTTPMethod
    var query: String
    
    init(query: String) {
        guard let url = URL(string: URL.searchRepositories + "q=\(query)") else { fatalError("Could not configure URL") }
        self.url = url
        self.method = .GET
        self.query = query
    }
    
    func request(callback: @escaping (APIResult) -> Void) {
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let urlResponse = response as? HTTPURLResponse else {
                callback(.failure(APIError.invalidResponse))
                return
            }
            switch urlResponse.statusCode {
            case 200...299:
                if let data = data {
                    do {
                        let repository = try JSONDecoder().decode(GithubRepository.self, from: data)
                        callback(.success(repository))
                    } catch {
                        callback(.failure(APIError.parseError(error.localizedDescription)))
                    }
                } else {
                    return  callback(.failure(APIError.noData))
                }
            case 400...499:
                return callback(.failure(APIError.badRequest(error?.localizedDescription)))
            case 500...599:
                return callback(.failure(APIError.serverError(error?.localizedDescription)))
            default:
                return callback(.failure(APIError.unknown))
            }
        }).resume()
    }
    
}

