import Foundation

final class MainViewModel: ObservableObject {

    // MARK: - Properties

    @Published var products: [ProductModel] = []
    @Published var errorText: String?
    var productsPerPage = 20
    var currentProductID = 1
    private var fetchTask: Task<Void, Never>?

    // MARK: - Functions

    @MainActor
    func fetchProducts() async {
        fetchTask?.cancel()

        fetchTask = Task {
            do {
                let products = try await APIManager.shared.fetchProducts(startID: currentProductID, count: productsPerPage)
                self.errorText = nil
                self.products = Array(products.prefix(20))
            } catch {
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
        currentProductID += productsPerPage
        await fetchProducts()
    }

    @MainActor
    func loadPreviousPage() async {
        currentProductID = max(1, currentProductID - productsPerPage)
        await fetchProducts()
    }
}
