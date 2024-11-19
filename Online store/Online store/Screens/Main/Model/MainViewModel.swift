import Foundation

final class MainViewModel: ObservableObject {

    // MARK: - Properties

    @Published var products: [ProductModel] = []
    @Published var errorText: String?
    var productsPerPage = 20
    var currentPage = 1
    private var fetchTask: Task<Void, Never>?

    // MARK: - Functions

    @MainActor
    func fetchProducts() async {
        fetchTask?.cancel()

        fetchTask = Task {
            do {
                let products = try await APIManager.shared.fetchProducts(
                    startID: (currentPage - 1) * productsPerPage + 1,
                    count: productsPerPage
                )

                guard !Task.isCancelled else { return }

                self.errorText = nil
                self.products = Array(products.prefix(20))
            } catch {
                guard !Task.isCancelled else { return }

                let networkError = NetworkError(error: error)
                self.errorText = networkError.rawValue
            }
        }
    }

    @MainActor
    func refresh() async {
        await fetchProducts()
    }

    @MainActor
    func loadNextPage() async {
        currentPage += 1
        await fetchProducts()
    }

    @MainActor
    func loadPreviousPage() async {
        currentPage = max(1, currentPage - 1)
        await fetchProducts()
    }
}
