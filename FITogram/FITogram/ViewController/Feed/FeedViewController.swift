//
//  FeedViewController.swift
//  FITogram
//
//  Created by Pacek on 20/04/2019.
//

import UIKit

class FeedViewController: UIViewController {

    private let viewModel = PhotosCollectionViewModel()

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        viewModel.didUpdatePhotos = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.updatePhotos()
    }

}

private extension FeedViewController {

    func setup() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PhotoTableViewCell.nib, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension FeedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = viewModel.photo(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        cell.configure(with: photo)
        return cell
    }

}

// 💩 duplicitní kód z GridViewController
extension FeedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 💩 FeedViewController musí vědět o tom jak vytvořit PhotoDetailViewController
        let storyboard = UIStoryboard(name: "PhotoDetail", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! PhotoDetailViewController
        viewController.hidesBottomBarWhenPushed = true
        viewController.viewModel = viewModel.photo(at: indexPath.row)
        // 💩 FeedViewController předpokládá, že je uvnitř UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
    }

}
