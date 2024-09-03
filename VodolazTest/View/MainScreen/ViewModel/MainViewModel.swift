import Foundation
import Combine


@MainActor
final class MainViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []
    
    @Published var currentSection: String = ""
    
    private(set) var allSection: [String] = []
    
    private let service: MainServiceProtocol
    
    private var cancellable: AnyCancellable? = nil
    
    init(service: MainServiceProtocol) {
        self.service = service
        
        makeSubscribe()
    }
    
    func getAllProducts() async {
        do {
            try await service.fetchAllProducts()
            
            let sections = service.getSectionNames()
            
            allSection = sections
            
            currentSection = allSection.first ?? "Unknown"
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func makeSubscribe() {
        cancellable = $currentSection
            .map { [weak self] section -> [Product]? in
                if let products = self?.service.productsSection.first(where: { $0.name == section }) {
                    return products.products
                }
                
                return nil
            }
            .sink(receiveValue: { [weak self] value in
                if let value {
                    self?.products = value
                }
            })
    }
}
