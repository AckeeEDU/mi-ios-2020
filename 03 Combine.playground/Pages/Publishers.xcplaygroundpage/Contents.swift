import Combine
//: [Previous](@previous) | [Terminology](Terminology)
//: # Publishers
//:
//: Combine provides several types of publishers for you to use
//: - `Empty` - never produce any value or error, only complete
//:
let empty = Empty<Int, Error>()
//:
//: - `Fail` - immediately terminate with given error
//:
let fail = Fail<Int, CustomError>(error: CustomError(message: "Fail publisher failed 👍"))
//:
//: - `Future` - some time in future produce a single value or finish with an error
//:
let futureSuccess = Future<Int, CustomError> { promise in
    promise(.success(10))
}

let futureFailure = Future<Int, CustomError> { promise in
    promise(.failure(CustomError(message: "Unable to fullfil promise 😔")))
}
//:
//: - `Just` - produce a single value and complete
//:
let just = Just(10)
//:
//: - `PassthroughSubject` - publisher that supports sending events from outside of its implementation
//:
let passthrough = PassthroughSubject<Int, CustomError>()
//:
//: - `CurrentValueSubject` - just like `PassthroughSubject` supports sending events from outside and also captures last sent value
//:
let currentValue = CurrentValueSubject<Int, CustomError>(10)
//:
//: [Next](@next)
