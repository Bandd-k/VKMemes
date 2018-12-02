import Foundation
import UIKit

class PagingFlowLayout: UICollectionViewFlowLayout {

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var targetContentOffset = proposedContentOffset
        if scrollDirection == .horizontal {
            let pageWidth = itemSize.width + minimumLineSpacing

            func page(offset: CGFloat) -> Int {
                return Int((offset + pageWidth / 2) / pageWidth)
            }
            guard let collection = collectionView else { return proposedContentOffset }
            let currentOffset = collection.contentOffset.x
            let numberOfItems = collection.numberOfItems(inSection: 0)
            let currentPage = page(offset: currentOffset)
            let minPage = max(0, currentPage - 1)
            let maxPage = min(numberOfItems, currentPage + 1)
            var targetPage = currentPage

            if velocity.x != 0 {
                let shift = velocity.x > 0 ? 1 : -1
                targetPage = min(maxPage, max(minPage, currentPage + shift))
            }
            targetContentOffset.x = CGFloat(targetPage) * pageWidth
        }
        return targetContentOffset
    }
}
