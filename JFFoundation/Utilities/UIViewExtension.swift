//
//  UIViewExtension.swift
//  JFFoundation
//
//  Created by 張哲豪 on 2020/3/5.
//  Copyright © 2020 張哲豪. All rights reserved.
//

import UIKit

public extension UIView {
    var top: CGFloat  {
        set{
            frame.origin.y = newValue
        }
        get{
            return frame.origin.y
        }
    }
    var bottom: CGFloat  {
        set{
            frame.origin.y = height - newValue
        }
        get{
            return frame.origin.y + height
        }
    }
    var height: CGFloat  {
        set{
            self.frame.size.height = newValue
        }
        get{
            return self.frame.size.height
        }
    }
    var width: CGFloat  {
           set{
               self.frame.size.width = newValue
           }
           get{
               return self.frame.size.width
           }
       }
    
    func asImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.isOpaque, UIScreen.main.scale)
        self.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.layer.add(animation, forKey: nil)
    }
    
    func animateHidden(isHidden: Bool)  {
        if isHidden == false {
            self.isHidden = isHidden
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = isHidden ? 0 : 1
        }) { (bool) in
            self.isHidden = isHidden
        }
    }
    
    func addLine(color: UIColor, direction: Direction , thickness: CGFloat = 0.5) {
        
        let line = viewWithTag(direction.rawValue) ?? UIView()
        line.tag = direction.rawValue
        line.backgroundColor = color
        line.isUserInteractionEnabled = false
        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false

        switch direction {
        case .up:
            line.heightAnchor.constraint(equalToConstant: thickness).isActive = true
            line.topAnchor.constraint(equalTo: topAnchor).isActive = true
            line.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            line.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        case .down:
            line.heightAnchor.constraint(equalToConstant: thickness).isActive = true
            line.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            line.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            line.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        case .left:
            line.widthAnchor.constraint(equalToConstant: thickness).isActive = true
            line.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            line.topAnchor.constraint(equalTo: topAnchor).isActive = true
            line.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        case .right:
            line.widthAnchor.constraint(equalToConstant: thickness).isActive = true
            line.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            line.topAnchor.constraint(equalTo: topAnchor).isActive = true
            line.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        }
    }
}

///IBInspectable 相關
public extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
