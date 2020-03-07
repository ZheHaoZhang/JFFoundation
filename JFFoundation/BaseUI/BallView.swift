//
//  BallView.swift
//  CFoundation
//
//  Created by 張哲豪 on 2019/8/30.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit

@IBDesignable
///UIimageView與UILabel 組合
class BallView: UIView {
    //MARK: label 相關
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 5
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        return label
    }()
    @IBInspectable
    open var text: String? {
        get {
            return label.text
        }
        set {
            if let value = newValue {
                label.text = value
            } else {
                label.text = nil
            }
        }
    }
    @IBInspectable
    open var textColor: UIColor? {
        didSet { label.textColor = textColor }
    }
    /// default is system font 17 plain.
    open var font = UIFont.systemFont(ofSize: 17) {
        didSet { label.font = font}
    }
    
    
    //MARK: backgroundImage 相關
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        self.insertSubview(imageView, at: 0)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        return imageView
    }()
    
    @IBInspectable
    var backgroundImageName: String?{
        didSet{
            if let imageName = backgroundImageName {
                let dynamicBundle = Bundle(for: type(of: self))
                let image = UIImage(named: imageName, in: dynamicBundle, compatibleWith: nil)
                self.backgroundImageView.image = image
            }else{
                self.backgroundImageView.image = nil
            }
        }
    }
    var backgroundImage: UIImage? {
        didSet{
            if oldValue == backgroundImage {
//                print("一樣的不畫")
            }else{
                self.backgroundImageView.image = backgroundImage
            }
        }
    }
}
