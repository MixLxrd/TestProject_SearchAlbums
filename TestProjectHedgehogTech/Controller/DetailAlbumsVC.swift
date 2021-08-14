//
//  DetailAlbumsVC.swift
//  TestProjectHedgehogTech
//
//  Created by Михаил on 14.08.2021.
//

import UIKit
import WebKit

class DetailAlbumsVC: UIViewController {

    var request: URLRequest?
    
    private lazy var webview: WKWebView = {
        let web = WKWebView()
        web.toAutoLayout()
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

extension DetailAlbumsVC {
    private func setupLayout() {
        webview.load(request!)
        view.addSubview(webview)
        let constraints = [
            webview.topAnchor.constraint(equalTo: view.topAnchor),
            webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
