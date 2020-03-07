//
//  UIStackViewExtension.swift
//  JFFoundation
//
//  Created by 張哲豪 on 2020/3/5.
//  Copyright © 2020 張哲豪. All rights reserved.
//

import UIKit

public extension UIStackView {
    func hiddenAllArrangedSubviews() {
        for subview in arrangedSubviews {
            subview.isHidden = true
        }
    }
    
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
    func customize(backgroundColor: UIColor = .clear, radiusSize: CGFloat = 0) {
        let subView = addBackground(color: backgroundColor)
        
        subView.layer.cornerRadius = radiusSize
        subView.layer.masksToBounds = true
        subView.clipsToBounds = true
    }
    
    func addBackground(color: UIColor)-> UIView {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
        return subView
    }
}
