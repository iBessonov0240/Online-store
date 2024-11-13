import Foundation

enum NetworkError: String, Error {
    case notConnectedToInternet = "The Internet connection appears to be offline."
    case serverError = "Server error occurred. Please try again later."
    case unknown = "Unknown error"

    init(error: Error) {
        if (error as? URLError)?.code == .notConnectedToInternet {
            self = .notConnectedToInternet
        } else if (error as? URLError)?.code == .badServerResponse {
            self = .serverError
        } else {
            self = .unknown
        }
    }
}
