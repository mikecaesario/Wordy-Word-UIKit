//
//  WebViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 16/09/23.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {

    private let navigationBar = UIView()
    private let webView = WKWebView()
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        webView.load(URLRequest(url: url))
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        layoutUI()
    }
    
    private func setSheetDetentToMedium() {
        
        guard let sheet = navigationController?.sheetPresentationController else { return }
        
        sheet.animateChanges {
            sheet.selectedDetentIdentifier = .medium
        }
    }
    
    private func dismissWebViewController() {
        navigationController?.popViewController(animated: true)
    }
}

extension WebViewController {
    
    private func configureView() {
        
        view.backgroundColor = .background.primary
        
        navigationController?.isNavigationBarHidden = true
        
    }
    
    private func layoutUI() {
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = [navigationBar, webView]
        
        view.addSubviews(views)
        webView.layer.zPosition = -1
        
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 100),

            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


