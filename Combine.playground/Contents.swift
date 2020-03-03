import Combine
import Foundation
import UIKit
import PlaygroundSupport

// apiary: https://cookbook3.docs.apiary.io/#

//let empty = Empty<Int, Error>()
//
//let fail = Fail<Int, CustomError>(error: CustomError())

let future = Future<Int, CustomError> { promise in
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        promise(.success(1))
    }
    //    promise(.failure(CustomError()))
}

let future2 = Future<Int, CustomError> { promise in
    promise(.success(100))
    //    promise(.failure(CustomError()))
}

let just = Just(10)
just.sink { _ in
    
}

//future.sink(receiveCompletion: { completion in
//    switch completion {
//    case .finished: print("[COMPLETION] Finished")
//    case .failure(let error): print("[COMPLETION] Error " + error.localizedDescription)
//    }
//
//
//}) { print("[VALUE]", $0) }

//future.map { $0 + 1 }.sink(receiveCompletion: { _ in }) { print("[VALUE]", $0) }
//future.tryMap { value in
//    if value < 5 {
//        throw CustomError()
//    }
//    return value + 1
//}.sink(receiveCompletion: { completion in
//    switch completion {
//    case .finished: break
//    case .failure(let error): print("[COMPLETION] Error", error.localizedDescription)
//    }
//}) { print("[VALUE]", $0) }

//future.merge(with: just.setFailureType(to: CustomError.self))
//    .sink(receiveCompletion: { _ in }) { print("[VALUE]", $0) }

//future.flatMap { value in Just(value + 1).setFailureType(to: CustomError.self) }
//    .sink(receiveCompletion: { _ in }) { print("[VALUE]", $0) }

//future.handleEvents(receiveOutput: { print("[VALUE]", $0) }, receiveCompletion: { print("[COMPLETION]", $0) })



final class RecipesViewController: UITableViewController {
    private var disposeBag = Set<AnyCancellable>()
    private var recipes = [Recipe]() {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Recipes"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let ai = UIActivityIndicatorView()
        ai.startAnimating()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: ai)
        
        fetchRecipes()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error): self?.handleError(error)
                }
                self?.navigationItem.rightBarButtonItem = nil
                }, receiveValue: { [weak self] recipes in
                    self?.recipes = recipes
            })
            .store(in: &disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        return cell
    }
    
    private func handleError(_ error: Error) {
        let alertVC = UIAlertController(title: "Error occured", message: error.localizedDescription, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true)
    }
    
    private func fetchRecipes() -> AnyPublisher<[Recipe], CustomError> {
        let url = URL(string: "https://cookbook.ack.ee/api/v1/recipes?limit=100&offset=0")!
        let urlPublisher = URLSession.shared.dataTaskPublisher(for: url)
        return urlPublisher.map { $0.data }
            .delay(for: 1, scheduler: DispatchQueue.global())
            .decode(type: [Recipe].self, decoder: JSONDecoder())
            .mapError { _ in CustomError() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

let recipesVC = RecipesViewController()
PlaygroundPage.current.liveView = UINavigationController(rootViewController: recipesVC)
