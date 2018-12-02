import Foundation
import UIKit

final class MainCell: UITableViewCell {
    let stackView: UIStackView
    let headerView = PostHeaderView()
    let actionView = ActionBarView()
    let imagesCarousel = CarouselView()
    let postText = PostTextView()

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
        stackView.addArrangedSubview(imagesCarousel)
        stackView.addArrangedSubview(actionView)
        addShadowBackground()
    }
    func configure(post: Post) {
        headerView.configure(post: post)
        actionView.configure(likes: post.likes, comments: post.comments, reposts: post.reposts, watchers: post.views)
        postText.configure(text: post.postText, showButton: false, buttonPressed: nil)
        if post.pictures.count == 0 {
            imagesCarousel.isHidden = true
        } else {
            imagesCarousel.configure(images: post.pictures)
        }

    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
