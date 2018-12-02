import Foundation
import UIKit

struct Post {
    let date: Double = 23.5
    let image = UIImage(named: "lima")
    let postText = "Configure SwiftLint by adding a .swiftlint.yml file from the directory you'll run SwiftLint from. The following parameters can be configured"
    let authorName = "Adriana Lima"
    let likes = 55
    let comments = 4
    let views = 1000
    let reposts = 3
    let pictures: [String] = ["lima", "sara", "sara", "lima", "sara", "lima", "sara"]
}
