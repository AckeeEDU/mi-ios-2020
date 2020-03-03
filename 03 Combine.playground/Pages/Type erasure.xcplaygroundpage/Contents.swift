import Combine
import Foundation
//: [Previous](@previous) | [UI](UI)
//: # Type erasure
//: - `Publisher` is protocol with associated types so very often it is quite complicated to pass it arround because it is often required to pass something that implements that protocol
//: - type erasure does just that...you take something that implements publisher and has those associated types and converts it to `struct AnyPublisher<Output, Failure> where Failure : Error`
//:
//: Lets say that you have function that should return a publisher, you get this error
//: > ❗️ protocol 'Publisher' can only be used as a generic constraint because it has Self or associated type requirements

//func fetchRecipes() -> Publisher? {
//    nil
//}

//: So you need to erase that type ☝️
func fetchRecipes() -> AnyPublisher<[Recipe], Error> {
    Empty().eraseToAnyPublisher()
}
//: And its almost the same story with publishers that apply some operations
//: This code is just fine:
let justWithOperations = Just(10).map { $0 + 5 }.flatMap { Just($0 + 3) }.append(Just(7))
//: But look at its type! 🕵️‍♂️
print(type(of: justWithOperations))
//: So if you want to pass it as an argument, it would be a nightmare, you don't want to write functions like this, do you?
func fetchRecipes(limitPublisher: Publishers.Concatenate<Publishers.FlatMap<Just<Int>, Just<Int>>, Just<Int>>) -> AnyPublisher<[Recipe], Error> {
    Empty().eraseToAnyPublisher()
}

fetchRecipes(limitPublisher: justWithOperations)

//: This looks a lot nicer
func fetchRecipes(limit: AnyPublisher<Int, Never>) -> AnyPublisher<[Recipe], Error> {
    Empty().eraseToAnyPublisher()
}

fetchRecipes(limit: justWithOperations.eraseToAnyPublisher())

//: This also means that you can really pass any Publisher, that has given signature, the `fetchRecipes(limitPublisher:)` has the issue that you would need to perform the exact same operations in the exact same order,
//: when you want to use this function which would be really annoying 😡

//: [Next](@next)
