import Combine
import UIKit
//: [Previous](@previous) |  [Creating own publishers 2](Creating own publishers 2)
//: # Good practices
//: When running variadic number of publishers, it is impossible to have a property for every `Cancellable`,
//: to simplify this, **Combine** has support of _Dispose bag_, you can simply store any `Cancellable` in `Set<AnyCancellable>`,
//: to make this convenient, we are given `store(in:)` function on `Cancellable`
var disposeBag = Set<AnyCancellable>()
Just(10).sink { _ in }.store(in: &disposeBag)
//: So if you have your publishers in a `Collection` you can run them without much problem
(0..<arc4random_uniform(10)).map { Just($0) }
    .forEach { $0.sink { print("[VALUE]", $0) }.store(in: &disposeBag) }
//: [Next](@next)


