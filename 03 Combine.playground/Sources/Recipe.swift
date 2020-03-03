import Foundation

public struct Recipe: Identifiable, Decodable, Hashable {
    public let id: String
    public let name: String
    public let duration: Int
    public let score: Double
}
