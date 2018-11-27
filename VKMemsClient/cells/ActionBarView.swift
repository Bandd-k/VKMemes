import Foundation
import UIKit

final class ActionBarView: UIView {
    let stackView: UIStackView

    let likes: ButtonCounterView
    let comments: ButtonCounterView
    let reposts: ButtonCounterView
    let watchers: ButtonCounterView

    override init(frame: CGRect) {
        let likes = ButtonCounterView(image: "Like_outline_24".image)
        self.likes = likes

        let comments = ButtonCounterView(image: "Comment_outline_24".image)
        self.comments = comments

        let reposts = ButtonCounterView(image: "Share_outline_24".image)
        self.reposts = reposts

        let watchers = ButtonCounterView(image: "View_20".image)
        self.watchers = watchers

        let stack = UIStackView(arrangedSubviews: [likes, comments, reposts])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 20
        self.stackView = stack

        super.init(frame: .zero)
        self.addSubview(stack)
        self.addSubview(watchers)

        stackView.pinBounds(except: .right)
        stackView.heightAnchor.constraint(equalToConstant: 48).isActive = true

        watchers.pinBounds(except: .left)

        watchers.leftAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0)
    }

    func configure(likes: Int, comments: Int, reposts: Int, watchers: Int) {
        self.likes.configure(counter: "\(likes)")
        self.comments.configure(counter: "\(comments)")
        self.reposts.configure(counter: "\(reposts)")
        self.watchers.configure(counter: "\(watchers)")
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}

final class ButtonCounterView: UIView {
    let counterLabel: UILabel
    let actionButton: UIButton
    init(image: UIImage) {
        let label = UILabel(frame: .zero)
        label.font = .headerButtons
        label.textColor = .buttonColor

        let button = UIButton()
        button.tintColor = .buttonColor
        button.setImage(image, for: .normal)

        self.counterLabel = label
        self.actionButton = button
        super.init(frame: .zero)
        addSubview(button)
        addSubview(label)

        button.pinBounds(except: .right)
        label.pinBounds(except: .left)

        label.leftAnchor.constraint(equalTo: button.rightAnchor, constant: 4).isActive = true
    }

    func configure(counter: String) {
        counterLabel.text = counter
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
