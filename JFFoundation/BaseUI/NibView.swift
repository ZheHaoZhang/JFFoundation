//
//  NibView.swift
//  TreviSchoolAssignment
//
//  Created by 張哲豪 on 2019/5/8.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit

//@IBDesignable
open class NibView: UIView {
    open var contentView: UIView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        // Setup view from .xib file
        xibSetup()
        viewDidLoad()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Setup view from .xib file
        xibSetup()
        viewDidLoad()
    }
//    override func prepareForInterfaceBuilder() {
//        // *****視圖並觸發IB渲染
//        // 有點吃Xcode的效能
//    }
    open func viewDidLoad() {
        //
    }
}
private extension NibView {
    
    func xibSetup() {
        backgroundColor = UIColor.clear
        contentView = loadNib()
        // use bounds not frame or it'll be offset
        contentView.frame = bounds
        // Adding custom subview on top of our view
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": contentView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": contentView]))
    }
}
extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}

