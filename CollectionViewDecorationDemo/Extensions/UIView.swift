

import UIKit


extension UIView {
    
    func drawShadow(shadowColor: CGColor = UIColor.darkGray.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 1.5),
                   shadowOpacity: Float = 0.15,
                   shadowRadius: CGFloat = 2.5) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
