//
//  FacebookWebViewController.swift
//  Todo
//
//  Created by Pratham Gupta on 03/03/23.
//

import UIKit
import WebKit

class FacebookWebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
//        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.facebook.com/login/")!
        webView.load(URLRequest(url: url))
        // Do any additional setup after loading the view.
        webView.allowsBackForwardNavigationGestures = true
    }

}
