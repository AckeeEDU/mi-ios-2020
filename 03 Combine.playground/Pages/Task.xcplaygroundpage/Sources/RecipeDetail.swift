import Foundation

public struct RecipeDetail: Decodable, Identifiable {
    public let id: String
    public let name: String
    public let description: String
    public let duration: Int
    public let ingredients: [String]
    public let info: String
    public let score: Double
}
