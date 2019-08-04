

import UIKit


class DecorationReusableView : UICollectionReusableView {
    
    static var reuse = "CollectionReusableView"
    
    override var reuseIdentifier: String? {
        return DecorationReusableView.reuse
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.customInit()
    }
    
    func customInit() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8.0
        drawShadow()
    }
}
