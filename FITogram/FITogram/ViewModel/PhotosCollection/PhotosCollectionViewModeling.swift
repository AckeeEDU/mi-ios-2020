//
//  PhotosCollectionViewModeling.swift
//  Mendelugram
//
//  Created by Pacek on 24/04/2019.
//

import Foundation

protocol PhotosCollectionViewModeling {

    var didUpdatePhotos: (() -> Void)? { get set }

    func updatePhotos()
    func numberOfPhotos() -> Int
    func photo(at index: Int) -> PhotoViewModeling

}
