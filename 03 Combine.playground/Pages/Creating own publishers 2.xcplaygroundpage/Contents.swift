import Combine
import Foundation
//: [Previous](@previous) | [Creating own publishers](Creating own publishers)
//: # Creating own publishers 2
//: Very often you would just need to observe some values on your objects, so let's try that
final class Storage {
    private(set) var latestAccess: Date? {
        didSet { _latestAccessSubject.send(latestAccess) }
    }
    
    var latestAccessPublisher: AnyPublisher<Date?, Never> { _latestAccessSubject.eraseToAnyPublisher() }
    
    private let _latestAccessSubject = PassthroughSubject<Date?, Never>()
    
    func access() {
        latestAccess = Date()
    }
}

let storage = Storage()
let cancellable = storage.latestAccessPublisher.sink(receiveValue: { print("[NEW_ACCESS]", $0 ?? "(nil)") })

storage.access()

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    storage.access()
}
//: Well while this code works just fine, if you have a bunch of properties, you will end up with lot of boilerplate code, just forwarding calls,
//: but luckily, you can do it in a much simpler way using `@Published` property wrapper
final class SimpleStorage {
    @Published private(set) var latestAccess: Date?
    
    func access() {
        latestAccess = Date()
    }
}

let simpleStorage = SimpleStorage()
let simpleCancellable = simpleStorage.$latestAccess.sink(receiveValue: { print("[NEW_SIMPLE_ACCESS]", $0 ?? "(nil)") })

simpleStorage.access()

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    simpleStorage.access()
}
//: `@Published` property wrapper is available only on reference types (classes)
//: - it will not make any sense on value types
//: - when value will change, new instance would be created thus the old publisher will not be triggered
//: [Next](@next)
