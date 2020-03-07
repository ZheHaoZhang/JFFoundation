//
//  PopupViewController.swift
//  Airship
//
//  Created by 張哲豪 on 2019/6/6.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit

open class PopupDatePickerViewController: UIViewController {

    @IBOutlet var popupView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet var exitButton: UIButton!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    var tapGesture: UITapGestureRecognizer!
    var effect:UIVisualEffect! //tmp
    var deonClosure: ((Date)->())?

    
    open class func show(selectＤate: Date, closure:((Date)->())?) -> PopupDatePickerViewController {
        let vc = self.simpleCreation(selectＤate: selectＤate, closure: closure)
        if let rootVC = rootViewController{
            rootVC.present(vc, animated: false, completion: nil)
        }
        return vc
    }
    
    open class func simpleCreation(selectＤate: Date, closure:((Date)->())?) -> PopupDatePickerViewController {
        let storyboardName = "PopupDatePickerViewController"
        let storyboardBundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopupDatePickerViewController") as! PopupDatePickerViewController
        vc.deonClosure = closure
        vc.datePicker.date = selectＤate
        return vc
    }
    override open func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(self.datePickerChanged), for: .valueChanged)
        doneButton.addTarget(self, action: #selector(self.doneButtonAction), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        effect = visualEffectView.effect
        visualEffectView.effect = nil
        if self.tapGesture == nil {
            self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.backAction))
            self.visualEffectView.addGestureRecognizer(tapGesture)
        }
    }
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.animateIn()
    }
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func animateIn() {
        self.view.addSubview(popupView)
        setupLayout()
//        popupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
//        popupView.alpha = 0
        
        popupView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        
        func step1() {
            UIView.animate(withDuration: 0.25, animations: {
                self.visualEffectView.effect = self.effect
                self.popupView.transform = CGAffineTransform.init(scaleX: 1.02, y: 1.02)
            }) { (finished) in
               step2()
            }
        }
        func step2() {
            UIView.animate(withDuration: 0.1, animations: {
                self.popupView.transform = CGAffineTransform.init(scaleX: 0.99, y: 0.99)
            }, completion: { (finished) in
                step3()
            })
        }
        func step3() {
            UIView.animate(withDuration: 0.05) {
                self.popupView.transform = CGAffineTransform.identity
            }
        }
        step1()
    }
    func setupLayout() {
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popupView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
//        popupView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
    }
    @objc func datePickerChanged(datePicker:UIDatePicker)  {
        if datePicker.date > Date() {
            datePicker.date = Date()
        }
    }
    @objc func doneButtonAction() {
        self.deonClosure?(datePicker.date)
        self.backAction()
    }

    @objc func backAction() {
        self.dismiss(animated: false) {
            //
        }
    }
    deinit {
        print("PopupDatePickerViewController deinit...")
    }
}
