import Foundation

struct ProductResponce: Codable {
    let status: String
    let message: String
    let productSection: [ProductSection]
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case productSection = "TOVARY"
    }
}

struct ProductSection: Identifiable, Codable {
    let id: Int
    let name: String
    let products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "NAME"
        case products = "data"
    }
    
}

struct Product: Identifiable, Codable {
    let id: String
    let picture: String
    let extendedPrice: [ExtendedPrice]
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case picture = "DETAIL_PICTURE"
        case extendedPrice = "EXTENDED_PRICE"
    }
}

extension Product {
    static let mockProduct = Product(id: "12332",
                                     picture: "https://szorin.vodovoz.ru//upload/iblock/b4e/73v459ifoerdgo9m6435wv39v7c52e1c.jpeg",
                                     extendedPrice: [ExtendedPrice(price: 112)])
}

struct ExtendedPrice: Codable {
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case price = "PRICE"
    }
}
