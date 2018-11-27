import Foundation
import UIKit

class PostTextView: UIView {
    let textField: UILabel
    let stackView: UIStackView
    let showMoreButton: UIButton
    var action: VoidFunc?
    override init(frame: CGRect) {
        let textLabel = UILabel()
        let button = UIButton()
        let stack = UIStackView(arrangedSubviews: [textLabel, button])
        stack.axis = .vertical
        self.stackView = stack

        button.setTitle("Показать Полностью...", for: .normal)
        button.titleLabel?.font = .showMore
        button.setTitleColor(.blue, for: .normal)
        button.contentHorizontalAlignment = .left
        textLabel.numberOfLines = 8
        textLabel.font = .plain
        self.textField = textLabel
        self.showMoreButton = button
        super.init(frame: frame)
        addSubview(stack)
        stack.pinBounds(left: 0, top: 0, right: 0, bottom: -4)
        showMoreButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }

    func configure(text: String, showButton: Bool, buttonPressed: VoidFunc?) {
        textField.text = text
        textField.numberOfLines = showButton ? 8 : 0
        showMoreButton.isHidden = !showButton
        action = buttonPressed
    }

    @objc func tap() {
        action?()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
