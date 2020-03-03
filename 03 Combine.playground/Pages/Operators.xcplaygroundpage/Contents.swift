import Combine
import Foundation
//: [Previous](@previous) | [Subscribers](Subscribers)
//: # Operators
//:
//: **Map**
//: - transform value to another value
//: - cannot fail, just returns transformed value
let value = Just(2)
value.map { $0 * $0 }.sink { print("[MAPPED]", $0) }
//:
//: **TryMap**
//: - just like `map` but this time it takes throwing closure
//: - this means that it can fail if given closure throws an error
let tryValue = Just("")
tryValue.tryMap { value in
    if value.isEmpty { throw CustomError(message: "Empty string doesn't have a first letter ⛔️") }
    return String(value.first!)
}.sink(receiveCompletion: { print("[TRY_MAPPED_COMPLETION]", $0) }) { print("[TRY_MAPPED]", $0) }
//: **Merge**
//: - when you're interested in any changes from more publishers
//: - as all publishers are merged into a single stream, they need to have the same `Output` and `Failure` types
let publisher1 = Just(1)
let publisher2 = Just(2).delay(for: 1, scheduler: RunLoop.main)
let merged = publisher1.merge(with: publisher2)
let mergedCancellable = merged.sink { print("[MERGED_VALUE]", Date(), $0) }
//: **FlatMap**
let flatMappedCancellable = merged.flatMap { Just($0 + 5) }.sink { print("[FLATMAPPED_VALUE]", $0) }
//: **Side effects ➡️ `handle`**
//: - generally you should try to avoid side effects
//: - useful e.g. for logging
let handleCancellable = merged.handleEvents(receiveOutput: { print("[VALUE_HANDLE]", $0) })
    .sink { _ in }
//: [Next](@next)
