import SwiftUI

struct ProductCell: View {

    // MARK: - Property

    let image: String
    let title: String
    let stock: Int
    let price: Double

    // MARK: - View

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: image)) { productImage in
                productImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .background(Color.clear)
            } placeholder: {
                ProgressView()
                    .frame(width: 64, height: 64)
            }

            Text(title)
                .foregroundColor(Color.blue.opacity(0.7))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(4)
                .minimumScaleFactor(0.5)
                .bold()

            VStack {
                Text("Stock")
                    .fontWeight(.light)

                Text("\(stock)")
                    .fontWeight(.semibold)
                    .foregroundColor(stock < 10 ? .red : .green)
            }
            .frame(maxWidth: .infinity, alignment: .center)

            VStack {
                Text("Price")
                    .fontWeight(.light)

                Text("\(price, specifier: "%.2f") $")
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(25)
        .overlay {
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.purple.opacity(0.3), lineWidth: 2)
        }
        .shadow(color: .blue.opacity(0.5), radius: 10)
        .padding(.bottom)
    }
}

#Preview {
    ProductCell(image: "", title: "Name of products", stock: 5, price: 19.99)
}
