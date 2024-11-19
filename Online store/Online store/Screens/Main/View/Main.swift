import SwiftUI

struct Main: View {

    // MARK: - Property

    @StateObject private var viewModel = MainViewModel()

    // MARK: - View

    var body: some View {
        VStack {
            Text("Online store")
                .padding(15)
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            if viewModel.products.isEmpty && viewModel.errorText == nil {
                ProgressView("Loading...")
                    .padding()
            } else {
                List(viewModel.products) { product in
                    ProductCell(
                        image: product.thumbnail,
                        title: product.title,
                        stock: product.stock,
                        price: product.price
                    )
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.top, 5)
                .padding(.horizontal)
                .scrollIndicators(.hidden)
                .listStyle(PlainListStyle())
                .refreshable {
                    await viewModel.refresh()
                }
            }

            if !viewModel.products.isEmpty {
                HStack {
                    Button(action: {
                        Task {
                            await viewModel.loadPreviousPage()
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue)
                            .padding(5)
                    })
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.purple.opacity(0.7))
                    }
                    .padding(.leading, 45)
                    .disabled(viewModel.currentPage == 1)

                    Spacer()

                    Button(action: {
                        Task {
                           await viewModel.loadNextPage()
                        }
                    }, label: {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue)
                            .padding(5)
                    })
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.purple.opacity(0.7))
                    }
                    .padding(.trailing, 45)
                    .disabled(viewModel.products.count < viewModel.productsPerPage)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchProducts()
            }
        }
        .overlay {
            if let errorText = viewModel.errorText {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()

                    ErrorPopup(errorText: errorText) {
                        Task {
                            viewModel.errorText = nil
                            await viewModel.fetchProducts()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Main()
}
