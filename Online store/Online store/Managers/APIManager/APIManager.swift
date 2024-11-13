import Foundation

final class APIManager {

    static let shared = APIManager()
    private let baseURL = "https://dummyjson.com/products"

    func fetchProducts(startID: Int, count: Int) async throws -> [ProductModel] {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "limit", value: "\(count)"),
            URLQueryItem(name: "skip", value: "\(startID - 1)")
        ]

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ProductsResponse.self, from: data)

        return response.products
    }
}
