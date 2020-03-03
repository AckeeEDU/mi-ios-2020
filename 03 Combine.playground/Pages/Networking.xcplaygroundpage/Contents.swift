import Combine
import Foundation
//: [Previous](@previous) | [Operators](Operators)
//: # Networking
//: - `URLSession` provides a publisher for making requests
let url = URL(string: "https://cookbook.ack.ee/api/v1/recipes?limit=10&offset=0")!
let taskPublisher = URLSession.shared.dataTaskPublisher(for: url)
let taskCancellable = taskPublisher.sink(receiveCompletion: { print("[TASK_COMPLETION]", $0) }, receiveValue: {
    print("[VALUE]", $0)
})
//: ## `Codable` support
//: - you get `Codable` support almost out of the box as you can decode any stream that has `Data` as its input
let mappingCancellable = taskPublisher.map { $0.data }
    .decode(type: [Recipe].self, decoder: JSONDecoder())
    .sink(receiveCompletion: { print("[MAPPING_COMPLETION]", $0) }, receiveValue: {
        $0.forEach { print("[MAPPED]", $0.name) }
    })
//: [Next](@next)
