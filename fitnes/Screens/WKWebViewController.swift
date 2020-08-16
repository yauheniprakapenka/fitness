//
//  WKWebViewController.swift
//  fitnes
//
//  Created by yauheni prakapenka on 11.08.2020.
//  Copyright © 2020 yauheni prakapenka. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController, WKUIDelegate {
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    var urlString = "http://mail.ru"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWerView()
        
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func configureWerView() {
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
}
