import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "szorin.vodovoz.ru"
        urlComponents.path = path
        
        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            preconditionFailure("Invalid URL components: \(urlComponents)")
        }
        
        return url
    }
}

extension Endpoint {
    static var glavnaya: Self {
        Endpoint(path: "/newmobile/glavnaya/super_top.php",
                 queryItems: [URLQueryItem(name: "action", value: "topglav")])
    }
}
