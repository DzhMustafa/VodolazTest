import SwiftUI

struct ProductCardView: View {
    
    let product: Product
    
    @State var image: UIImage? = nil
    
    var body: some View {
        VStack {
            Image(systemName: "heart")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            productImage()
            
            if let extendedPrice = product.extendedPrice.first {
                bottomContent(price: extendedPrice.price)
            }
        }
        .padding(7)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(radius: 2)
        }
        .frame(width: 160, height: 200)
        .task {
            await loadImage(with: product.picture)
        }
    }
    
    func loadImage(with urlString: String) async {
        guard let url = URL(string: "https://szorin.vodovoz.ru/" + urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let image = UIImage(data: data) {
                self.image = image
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

private extension ProductCardView {
    
    func productImage() -> some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 140)
            } else {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.gray)
                    .frame(width: 110, height: 140)
            }
        }
    }
    
    func bottomContent(price: Int) -> some View {
        HStack {
            Text("\(price) ₽")
                .bold()
            
            Spacer()

            Image(systemName: "basket")
                .foregroundStyle(.white)
                .frame(width: 30, height: 30)
                .background {
                    Circle()
                        .fill(.green)
                }
        }
    }
}

#Preview {
    ProductCardView(product: .mockProduct)
}
