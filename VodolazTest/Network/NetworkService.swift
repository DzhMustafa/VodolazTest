import Foundation

protocol NetworkServiceProtocol {
    func get<T:Codable>(with url: URL) async throws -> T
    
    // ......
}

final class NetworkService: NetworkServiceProtocol {
    func get<T>(with url: URL) async throws -> T where T : Decodable, T : Encodable {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        /*  Если требуется token
                        request.addValue("Bearer \(наш токен)", forHTTPHeaderField: "Authorization")
                 */
        
        let (data, responce) = try await URLSession.shared.data(for: request)
        
        try responce.isValidation()
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension URLResponse {
    func isValidation() throws {
        guard let httpResponce = self as? HTTPURLResponse, (200..<300).contains(httpResponce.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
