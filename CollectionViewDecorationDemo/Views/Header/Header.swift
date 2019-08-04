

import UIKit

class Header: UICollectionReusableView {
    
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var tapped: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gr = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewParent.addGestureRecognizer(gr)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        tapped?()
    }
}
