import Combine
import UIKit

public final class RecipeDetailViewController: UIViewController {
    private weak var descriptionLabel: UILabel!
    private weak var durationLabel: UILabel!
    private weak var ingredientsLabel: UILabel!
    
    private let recipe: Recipe
    
    @Published private var recipeDetail: RecipeDetail?
    
    private var disposeBag = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    public init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
        title = recipe.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    
    override public func loadView() {
        super.loadView()
        
        view.backgroundColor = .systemBackground
        
        let descriptionLabel = UILabel()
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
        descriptionLabel.numberOfLines = 0
        self.descriptionLabel = descriptionLabel
        
        let durationTitle = UILabel()
        durationTitle.text = "Duration"
        durationTitle.font = .preferredFont(forTextStyle: .headline)
        
        let durationLabel = UILabel()
        durationLabel.font = .preferredFont(forTextStyle: .body)
        self.durationLabel = durationLabel
        
        let ingredientsTitle = UILabel()
        ingredientsTitle.text = "Ingredients"
        ingredientsTitle.font = .preferredFont(forTextStyle: .headline)
        
        let ingredientsLabel = UILabel()
        ingredientsLabel.font = .preferredFont(forTextStyle: .body)
        ingredientsLabel.numberOfLines = 0
        self.ingredientsLabel = ingredientsLabel
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let vStack = UIStackView(arrangedSubviews: [descriptionLabel, ingredientsTitle, ingredientsLabel, durationTitle, durationLabel])
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 15),
            vStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 15),
            vStack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -15),
            vStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -15),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDetail()
        setupBindings()
    }
    
    // MARK: - Private helpers
    
    private func handleError(_ error: Error) {
        let alertVC = UIAlertController(title: "Error occured", message: error.localizedDescription, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertVC, animated: true)
        print("[ERROR]", error)
    }
    
    private func setupBindings() {
        $recipeDetail.map { $0?.description }
            .assign(to: \.text, on: descriptionLabel) // using `assign(to:on:)` you can assign values from publisher to certain properties of given object
            .store(in: &disposeBag)
        
        $recipeDetail.map { $0?.duration }
            .map { $0.map { String($0) + " min" } }
            .assign(to: \.text, on: durationLabel)
            .store(in: &disposeBag)
        
        $recipeDetail.map { $0?.ingredients ?? [] }
            .map { $0.joined(separator: "\n") }
            .assign(to: \.text, on: ingredientsLabel)
            .store(in: &disposeBag)
    }
    
    private func fetchDetail() {
        let url = URL(string: "https://cookbook.ack.ee/api/v1/recipes/" + recipe.id)!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: RecipeDetail.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error): self?.handleError(error)
                }
            }) { [weak self] recipe in
                self?.recipeDetail = recipe
        }.store(in: &disposeBag)
    }
}
