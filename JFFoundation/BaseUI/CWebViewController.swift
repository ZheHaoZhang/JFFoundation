//
//  CWebViewController.swift
//  Airship
//
//  Created by 張哲豪 on 2019/7/19.
//  Copyright © 2019 張哲豪. All rights reserved.
//

import UIKit
import WebKit

open class CWebViewController: UIViewController {

    // 优先顺序 urlString > fileUrl > htmlString
    open var urlString: String? {
        didSet{
            webView.myURLStr = urlString
        }
    }
    open var htmlString: String? {
        didSet{
            if let htmlString = self.htmlString {
                webView.loadHTMLString(htmlString, baseURL: nil)
            }
        }
    }
    open var fileUrl: URL? {
        didSet{
            webView.fileUrl = fileUrl
        }
    }
    open var progressColor: UIColor = .blue // 进度条颜色，有赋值，显示，不赋值，不显示
    
    open lazy var webView: CWebView = {
        //创建wkwebview
        let webView = CWebView.initialization(frame: self.view.frame)
        return webView
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil);
        webView.progressView.progressTintColor = progressColor
    }
    
    // Observe value
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let newProgress = Float(webView.estimatedProgress)
            print("Loaded: \(newProgress)")
            webView.progressView.progress = newProgress
            webView.progressView.isHidden = newProgress >= 0.9
        }
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeFromSuperview()
    }
}

open class CWebView: WKWebView {
    //初始化
    open class func initialization(frame: CGRect? = nil) -> CWebView {
        let webView: CWebView = {
            if let frame = frame {
                return CWebView.init(frame: frame)
            }else{
                return CWebView.init()
            }
        }()
        webView.progressView.isHidden = false //順便觸發lazy
        return webView
    }
    deinit {
        if let titleObserver = observation {
            titleObserver.invalidate()

        }
    }
    
    var observation: NSKeyValueObservation?
    open lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = UIColor.blue
        progressView.trackTintColor = UIColor(white: 0.7, alpha: 1.0)
        
        self.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        progressView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        progressView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        //MARK: 以下寫法會讓ios9爆炸,故改為由vc observe
//        observation = self.observe(\.estimatedProgress, options: .new, changeHandler: { [weak progressView](_, change) in
//            let newProgress = Float(change.newValue ?? 0)
//            print("Loaded: \(newProgress)")
//            progressView?.progress = newProgress
//            progressView?.isHidden = newProgress >= 0.9
//        })
        return progressView
    }()
    
    open var myURLStr: String?{
        didSet{
            guard let myURLStr = myURLStr else { return }
            let url = URL(string: myURLStr)
            let request = URLRequest(url: url!)
            self.load(request as URLRequest)
        }
    }
    
    open var fileUrl: URL?{
        didSet{
            guard let url = fileUrl else { return }
            let request = URLRequest(url: url)
            self.load(request as URLRequest)
        }
    }
    
    open func loadAgreement() {
        self.fileUrl = Bundle.main.url(forResource: "agreement", withExtension: "html")
    }
}
