import Foundation

struct ProductModel: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let stock: Int
    let thumbnail: String
}
