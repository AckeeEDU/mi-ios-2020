import Combine
import UIKit

public final class RecipesViewController: UITableViewController {
    private enum Constants {
        static let cellReuseIdentifier = "Cell"
    }
    
    private var recipes = [Recipe]() {
        didSet { tableView.reloadData() }
    }
    private var requestCancellable: Cancellable?
    
    // MARK: - View life cycle
    
    override public func loadView() {
        super.loadView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellReuseIdentifier)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let ai = UIActivityIndicatorView()
        ai.startAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: ai)
        
        let url = URL(string: "https://cookbook.ack.ee/api/v1/recipes?limit=100&offset=0")!
        let taskPublisher = URLSession.shared.dataTaskPublisher(for: url)
        requestCancellable = taskPublisher.map { $0.data }
            .decode(type: [Recipe].self, decoder: JSONDecoder())
            .delay(for: 2, scheduler: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.navigationItem.rightBarButtonItem = nil
                
                switch completion {
                case .finished: break // nothing to do
                case .failure(let error): self?.showRequestError(error)
                }
            }, receiveValue: { [weak self] recipes in
                self?.recipes = recipes
            })
    }
    
    // MARK: - UITableViewController overrides
        
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = recipes[indexPath.row].name
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeDetailVC = RecipeDetailViewController(recipe: recipes[indexPath.row])
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
    
    // MARK: - Private helpers
    
    private func showRequestError(_ error: Error) {
        let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertVC.addAction(.init(title: "OK", style: .default))
        present(alertVC, animated: true)
    }
}
