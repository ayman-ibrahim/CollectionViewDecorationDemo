

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {

    let edgeInset:CGFloat = 10
    let itemheight:CGFloat = 38
    let headerHeight:CGFloat = 70
    var itemWidth:CGFloat!
    var width:CGFloat!
    
    var collectionWidth: CGFloat {
        return collectionView?.bounds.size.width ?? 0
    }
    
    override func prepare() {
        super.prepare()
        
        width = collectionWidth - (edgeInset * 3)
        itemWidth = collectionWidth - (edgeInset * 4)
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        sectionInset = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
        
        itemSize = CGSize(width: itemWidth, height: itemheight)
        headerReferenceSize = CGSize(width: 1, height: headerHeight)
        register(DecorationReusableView.self, forDecorationViewOfKind: DecorationReusableView.reuse)
    }
    
    // MARK: layoutAttributesForElementsInRect
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var allAttributes: [UICollectionViewLayoutAttributes] = []
        if let attributesUnWrapped = attributes {
            for attr in attributesUnWrapped {
                if attr.representedElementCategory == UICollectionView.ElementCategory.supplementaryView {
                    if let decoAttributes = self.layoutAttributesForDecorationView(ofKind: DecorationReusableView.reuse, at: attr.indexPath) {
                        allAttributes.append( decoAttributes)
                    }
                }
            }
            allAttributes.append(contentsOf: attributesUnWrapped)
        }
        return allAttributes
    }

    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let decorator = UICollectionViewLayoutAttributes(forDecorationViewOfKind: DecorationReusableView.reuse, with: indexPath)
    
        if elementKind != DecorationReusableView.reuse {
            return decorator
        }
        
        let section = indexPath.section
        let height = getHeightForSection(section)
        let margins = sectionInset.top + sectionInset.bottom
        let size = CGSize(width: width, height: height + headerReferenceSize.height - edgeInset)
        var firstCellAttr: UICollectionViewLayoutAttributes?
        
        firstCellAttr = collectionView?.layoutAttributesForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        let x = firstCellAttr!.frame.minX + edgeInset * 1.5
        let origin = CGPoint(x: x, y: (firstCellAttr!.frame.minY - margins/2) + edgeInset * 2)
        
        decorator.size = size
        decorator.frame.origin = origin
        decorator.zIndex = -1
        
        return decorator
    }
    
    func getHeightForSection(_ section: Int) -> CGFloat {
        if section < 0 {
            return 0
        }
        let rows = CGFloat(((collectionView?.numberOfItems(inSection: section) ?? 0)))
        let height = (itemSize.height * rows) + minimumLineSpacing * (rows - 1) + sectionInset.top + sectionInset.bottom
        return height
    }
}
