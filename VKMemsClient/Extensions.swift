//
//  Fonts.swift
//  VKNewsFeed
//
//  Created by Denis Karpenko on 10/11/2018.
//  Copyright © 2018 Denis Karpenko. All rights reserved.
//

import Foundation
import UIKit

typealias VoidFunc = () -> ()

extension UIFont {
    static func SFProRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Regular", size: size)!
    }
    static func SFProMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Medium", size: size)!
    }

    static var plain: UIFont { return SFProRegular(ofSize: 15) }

    static var showMore: UIFont { return SFProMedium(ofSize: 15) }

    static var headerButtons: UIFont { return SFProMedium(ofSize: 14) }

    static var date: UIFont { return SFProRegular(ofSize: 12) }
}

extension UIColor {
    static var buttonColor: UIColor { return UIColor(red: 0.5, green: 0.55, blue: 0.6, alpha: 1) }
}

extension String {
    var image: UIImage { return UIImage(named: self)! }
}

extension UIView {
    enum Side {
        case top
        case bottom
        case left
        case right
    }

    func pinBounds(offset: CGFloat = 0, except side: Side? = nil) {
        guard let parent = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if side != .left {
            leftAnchor.constraint(equalTo: parent.leftAnchor, constant: offset).isActive = true
        }
        if side != .right {
            rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -offset).isActive = true
        }
        if side != .top {
            topAnchor.constraint(equalTo: parent.topAnchor, constant: offset).isActive = true
        }
        if side != .bottom {
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -offset).isActive = true
        }
    }

    func pinBounds(left: CGFloat? = nil, top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil) {
        guard let parent = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        if left != nil {
            leftAnchor.constraint(equalTo: parent.leftAnchor, constant: left!).isActive = true
        }
        if top != nil {
            topAnchor.constraint(equalTo: parent.topAnchor, constant: top!).isActive = true
        }
        if right != nil {
            rightAnchor.constraint(equalTo: parent.rightAnchor, constant: right!).isActive = true
        }
        if bottom != nil {
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: bottom!).isActive = true
        }
    }

    func addShadowBackground() {
        let image = UIImage(named: "CardWithShadow")
        let backgroundView = UIImageView(image: image)
        insertSubview(backgroundView, at: 0)
        backgroundView.pinBounds(left: -10, top: 0, right: 10, bottom: 0)
    }
}

infix operator ?= : AssignmentPrecedence

func ?= <A>(lhs: inout A, rhs: A?) {
    if let value = rhs {
        lhs = value
    }
}

func ?= <A>(lhs: inout A?, rhs: A?) {
    if let value = rhs {
        lhs = .some(value)
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
