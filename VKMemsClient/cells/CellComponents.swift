import Foundation
import UIKit

struct PostHeaderModel {
    let name: String
    let date: Double
    let image: URL
    let pressMore: VoidFunc?
}

final class PostHeaderView: UIView {
    private static let imageViewSize: CGFloat = 36
    private static let offset: CGFloat = 8
    let avatarImageView: UIImageView
    let nameLabel: UILabel
    let dateLabel: UILabel

    override init(frame: CGRect) {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = PostHeaderView.imageViewSize / 2
        imageView.layer.masksToBounds = true
        self.avatarImageView = imageView

        let nameLabel = UILabel(frame: .zero)
        nameLabel.font = .headerButtons
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel = nameLabel
        let dateLabel = UILabel(frame: .zero)
        dateLabel.font = .date
        dateLabel.textColor = .buttonColor
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel = dateLabel

        super.init(frame: frame)
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(dateLabel)

        let offset = PostHeaderView.offset
        imageView.heightAnchor.constraint(equalToConstant: PostHeaderView.imageViewSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: PostHeaderView.imageViewSize).isActive = true

        imageView.pinBounds(left: 0, top: 0, bottom: -offset)

        nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: offset).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -offset).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true

        dateLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: offset).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -offset).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    func formatDate(value: Double) -> String {
        let date = NSDate(timeIntervalSince1970: value)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a" // maybe change later

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }

    func configure(post: Post) {
        dateLabel.text = formatDate(value: post.date)
        nameLabel.text = post.authorName
        avatarImageView.image = UIImage(named: "lima")
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

final class MainCell: UITableViewCell {
    let stackView: UIStackView
    let headerView = PostHeaderView()
    let actionView = ActionBarView()
    let postText = PostTextView()
    var short = true

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical

        self.stackView = stackView
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.pinBounds(offset: 16)

        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(postText)
        stackView.addArrangedSubview(actionView)
        addShadowBackground()
    }
    func configure(post: Post) {
        headerView.configure(post: post)
        actionView.configure(likes: post.likes, comments: post.comments, reposts: post.reposts, watchers: post.views)
        postText.configure(text: post.postText, showButton: false, buttonPressed: nil)

    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
