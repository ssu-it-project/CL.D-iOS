//
//  TermsWebViewController.swift
//  CLD
//
//  Created by 김규철 on 2023/08/20.
//

import UIKit
import WebKit

final class TermsWebViewController: BaseViewController, WKUIDelegate {
    
    var termsUrl: String?

    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: termsUrl ?? "")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
