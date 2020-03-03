import Combine
import Foundation
//: [Previous](@previous) | [Type erasure](Type erasure)
//: # Creating own publishers
//: - probably you wouldn't need it as you are provided with lot of implementations
//: - well if you really need it, the easiest way would be to incorporate `Subject` ➡️ `PassthroughSubject`/`CurrentValueSubject`
//:
let passthroughSubject = PassthroughSubject<Int, Never>()
let cancellable = passthroughSubject.sink(receiveCompletion: { print("[COMPLETION]", $0) }) { print("[VALUE]", $0) }
//: When you want to produce a new event, you just simply call `send`
passthroughSubject.send(10)
//: When you're done with your work (or you failed to do your work), you just send completion
passthroughSubject.send(completion: .finished)
//:
//: [Next](@next)
