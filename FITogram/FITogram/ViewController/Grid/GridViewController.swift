//
//  GridViewController.swift
//  FITogram
//
//  Created by Pacek on 20/04/2019.
//

import UIKit

class GridViewController: UIViewController {

    // 💩 GridViewController musí držet lokální kopii dat
    private var photos = [Photo]()

    @IBOutlet private weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        // 💩 duplicitní kód z FeedViewController
        // 💩 GridViewController zná konkrétní implementaci photoService (model vrstva)
        PhotosService.shared.fetchPhotos { [weak self] photos in
            self?.photos = photos
            self?.collectionView.reloadData()
        }
    }

}
private extension GridViewController {

    func setup() {
        let photosPerRow = 3
        let side = (Int(UIScreen.main.bounds.width) / photosPerRow) - 1
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: side, height: side)
            layout.minimumLineSpacing = 1
            layout.minimumInteritemSpacing = 1
        }

        collectionView.register(PhotoCollectionViewCell.nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension GridViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(
            with: PhotoCollectionViewCell.Input(
                // 💩 GridViewController musí umět přetavit photoId na UIImage
                photo: UIImage(photoId: photo.photoId)
            )
        )
        return cell
    }

}

extension GridViewController: UICollectionViewDelegate {

    // 💩 duplicitní kód z FeedViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 💩 GridViewController musí vědět o tom jak vytvořit PhotoDetailViewController
        let storyboard = UIStoryboard(name: "PhotoDetail", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! PhotoDetailViewController
        viewController.hidesBottomBarWhenPushed = true
        viewController.photo = photos[indexPath.row]
        // 💩 GridViewController předpokládá, že je uvnitř UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
    }

}
