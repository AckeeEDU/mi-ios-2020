import Combine
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
//: [Previous](@previous) | [Publishers](Publishers)
//: # Subscribers
//:
//: At first you need to have a publisher
let just = Just(10)
//: Then you can just simply subscribe
just.sink { value in
    print("[JUST_VALUE]", value)
}
//: You can also observe all events that go through the stream
let future = Future<Int, CustomError> { promise in
    print("[FUTURE_STARTING]")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//        promise(.success(5))
        promise(.failure(CustomError(message: "We failed ⛔️")))
    }
}

print("[FUTURE_SUBCRIBE]")
let cancellable = future.sink(receiveCompletion: { completion in
    switch completion {
    case .failure(let error):
        print("[FUTURE_ERROR]", error.message)
    case .finished:
        print("[FUTURE_FINISHED]")
    }
}) { value in
    print("[FUTURE_VALUE]", value)
}
//: [Next](@next)
