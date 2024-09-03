import SwiftUI


struct MainView: View {
    
    @StateObject var vm = MainViewModel(service: MainService(networkService: NetworkService()))
    
    var body: some View {
        ScrollView {
            VStack {
                filterPicker()
                
                productsList(products: vm.products)
            }
            .task {
                if vm.products.isEmpty {
                    await vm.getAllProducts()
                }
            }
            
        }
    }
}

private extension MainView {
    func filterPicker() -> some View {
        Picker("", selection: $vm.currentSection) {
            ForEach(vm.allSection, id: \.self) { sectionName in
                Text(sectionName)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(radius: 1)
        }
        .padding(.horizontal)
        .pickerStyle(.menu)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func productsList(products: [Product]) -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 25) {
                ForEach(products) { product in
                   ProductCardView(product: product)
                }
                
            }
            .padding()
        }
        .scrollIndicators(.never)
    }
}
#Preview {
    MainView()
}
