

import UIKit

private let reuseIdentifierCell = "Cell"
private let reuseIdentifierHeader = "header"

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let presenter = Presenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.layer.cornerRadius = 8
        collectionView.layer.masksToBounds = true
        collectionView.register(UINib(nibName: "Header", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifierHeader)
        
        presenter.didAdjustedData = { isDelete, arr in
            if isDelete {
                self.collectionView.deleteItems(at: arr)
            } else {
                self.collectionView.insertItems(at: arr)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.dataSource[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCell, for: indexPath) as! CollectionViewCell
        cell.lblTtile.text = String(presenter.dataSource[indexPath.section][indexPath.row])
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifierHeader, for: indexPath) as! Header
        headerView.lblTitle.text = "header \(indexPath.section + 1)"
        headerView.tapped = {
            self.presenter.toggleSection(indexPath.section)
        }
        return headerView
    }
    
}

