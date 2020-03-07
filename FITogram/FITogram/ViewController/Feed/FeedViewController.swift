//
//  FeedViewController.swift
//  FITogram
//
//  Created by Pacek on 20/04/2019.
//

import UIKit

class FeedViewController: UIViewController {

    // 💩 FeedViewController musí držet lokální kopii dat
    private var photos = [Photo]()

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        // 💩 duplicitní kód z GridViewController
        // 💩 FeedViewController zná konkrétní implementaci photoService (model vrstva)
        PhotosService.shared.fetchPhotos { [weak self] photos in
            self?.photos = photos
            self?.tableView.reloadData()
        }
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
        return photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photo = photos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        cell.configure(
            // 💩 FeedViewController musí umět přetavit Photo na Input pro PhotoTableViewCell
            with: PhotoTableViewCell.Input(
                avatar: UIImage(avatarId: photo.author.avatarId),
                authorName: photo.author.name,
                locationName: photo.locationName,
                photo: UIImage(photoId: photo.photoId)
            )
        )
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
        viewController.photo = photos[indexPath.row]
        // 💩 FeedViewController předpokládá, že je uvnitř UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
    }

}
