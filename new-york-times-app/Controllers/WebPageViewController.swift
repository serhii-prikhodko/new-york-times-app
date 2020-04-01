//
//  WebPageViewController.swift
//  new-york-times-app
//
//  Created by Serhiy Prikhodko on 4/1/20.
//  Copyright © 2020 Serhiy Prikhodko. All rights reserved.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {
    
    var url: String?

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = self.url {
            self.title = url
            self.loadPage(url)
        }
    }
    // MARK: - Functions
    func loadPage(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}
