
import UIKit

class PhotoDetailViewController: UIViewController {

    var photo: Photo!

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
        title = "\(photo.author.username)'s photo"
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
            return photo.comments.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.section(at: indexPath.section)
        switch section {
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
            cell.configure(
                with: PhotoTableViewCell.Input(
                    avatar: UIImage(avatarId: photo.author.avatarId),
                    authorName: photo.author.name,
                    locationName: photo.locationName,
                    photo: UIImage(photoId: photo.photoId)
                )
            )
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoDescriptionTableViewCell.identifier, for: indexPath) as! PhotoDescriptionTableViewCell
            cell.configure(
                with: PhotoDescriptionTableViewCell.Input(
                    likesCount: photo.likesCount,
                    username: photo.author.username,
                    description: photo.description
                )
            )
            return cell
        case .comments:
            let comment = photo.comments[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
            cell.configure(
                with: CommentTableViewCell.Input(
                    avatar: UIImage(avatarId: comment.author.avatarId),
                    username: comment.author.username,
                    comment: comment.text
                )
            )
            return cell
        }
    }

}
