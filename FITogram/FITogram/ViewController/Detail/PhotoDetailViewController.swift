//
//  PhotoDetailViewController.swift
//  FITogram
//
//  Created by Pacek on 21/04/2019.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    var viewModel: PhotoViewModeling!

    enum Section: Int, CaseIterable {
        case photo
        case description
        case comments
    }

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

}

private extension PhotoDetailViewController {

    func setup() {
        title = viewModel.title
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PhotoTableViewCell.nib, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.register(CommentTableViewCell.nib, forCellReuseIdentifier: CommentTableViewCell.identifier)
        tableView.register(PhotoDescriptionTableViewCell.nib, forCellReuseIdentifier: PhotoDescriptionTableViewCell.identifier)
        tableView.dataSource = self
    }

    func section(at index: Int) -> Section {
        guard let section = Section(rawValue: index) else {
            fatalError("invalid section")
        }
        return section
    }

}

extension PhotoDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.section(at: section) {
        case .photo, .description:
            return 1
        case .comments:
            return viewModel.numberOfComments()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.section(at: indexPath.section)
        switch section {
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
            cell.configure(with: viewModel)
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoDescriptionTableViewCell.identifier, for: indexPath) as! PhotoDescriptionTableViewCell
            cell.configure(with: viewModel)
            return cell
        case .comments:
            let comment = viewModel.comment(at: indexPath.item)
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
            cell.configure(with: comment)
            return cell
        }
    }

}
