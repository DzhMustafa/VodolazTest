import Foundation

protocol MainServiceProtocol: AnyObject {
    var productsSection: [ProductSection] { get set }
    
    var networkService: NetworkService { get }
    
    func getAllProducts() async throws -> Void
    
    func getSectionNames() -> [String]
}

final class MainService: MainServiceProtocol {
    @Published var productsSection: [ProductSection] = []
    
    var networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getAllProducts() async throws  {
        let endpoint = Endpoint.glavnaya
                
        let responce: ProductResponce = try await networkService.get(with: endpoint.url)
        
        self.productsSection = responce.productSection
    }
    
    func getSectionNames() -> [String] {
        productsSection.map { $0.name }
    }
}
