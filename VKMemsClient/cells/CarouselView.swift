import Foundation
import UIKit

final class CarouselView: UIView {
    let collectionView: UICollectionView
    let pageControl: UIPageControl
    var source = [UIImage(named: "lima")!, UIImage(named: "sara")!, UIImage(named: "lima")!, UIImage(named: "sara")!, UIImage(named: "lima")!] {
        didSet {
            pageControl.numberOfPages = source.count
        }
    }

    override init(frame: CGRect) {
        let layout = PagingFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero

        layout.itemSize = CGSize(width: 340, height: 300)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView = collection

        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: "2")

        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = source.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .pageControl
        pageControl.currentPageIndicatorTintColor = .pageIndicatorControl
        self.pageControl = pageControl
        let stackView = UIStackView(arrangedSubviews: [collectionView, pageControl])
        stackView.axis = .vertical
        super.init(frame: .zero)

        collectionView.delegate = self
        addSubview(stackView)

        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        collectionView.dataSource = self
        stackView.pinBounds(left: -8, top: 0, right: 8, bottom: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.layoutIfNeeded()
        let size = collectionView.bounds.size
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: size.width, height: size.height)
        layout?.invalidateLayout()
    }

    func configure(images: [String]) {
        source = images.map { UIImage(named: $0)! }
        pageControl.currentPage = 0
        if images.count == 1 {
            pageControl.isHidden = true
            collectionView.isScrollEnabled = false
        }
        collectionView.reloadData()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension CarouselView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension CarouselView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return source.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "2", for: indexPath) as! ImageCollectionCell
        cell.configure(image: source[indexPath.row])
        return cell
    }
}

class ImageCollectionCell: UICollectionViewCell {
    let imageView: UIImageView

    override init(frame: CGRect) {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        self.imageView = imageView

        super.init(frame: .zero)

        self.addSubview(imageView)
        imageView.pinBounds()
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    func configure(image: UIImage) {
        imageView.image = image
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
