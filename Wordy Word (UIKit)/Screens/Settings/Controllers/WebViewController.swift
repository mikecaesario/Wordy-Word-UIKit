//
//  WebViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 16/09/23.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {

    private let navigationBar = WebNavigation()
    private var webView: WKWebView!
    
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
        
        prepareWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        goToWeb(withURL: url)
    }
    
    deinit {
        
        removeObserver()
    }
    
    private func goToWeb(withURL: URL?) {
        
        guard let url = withURL else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    private func setSheetDetentToMedium() {
        
        guard let sheet = navigationController?.sheetPresentationController else { return }
        
        sheet.animateChanges {
            sheet.selectedDetentIdentifier = .medium
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        switch keyPath {
            
        case #keyPath(WKWebView.canGoBack):
            
            navigationBar.isBackButtonEnabled(isEnabled: webView.canGoBack)
        case #keyPath(WKWebView.canGoForward):
            
            navigationBar.isForwardButtonEnabled(isEnabled: webView.canGoForward)
        default:
            break
        }
    }
    
    private func removeObserver() {
        
        if webView.observationInfo != nil {
            
            webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward))
            webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack))
        }
    }
}

extension WebViewController {
    
    private func configureView() {
        
        view.backgroundColor = .background.primary
        
        navigationController?.isNavigationBarHidden = true
        
        navigationBar.delegate = self
    }
    
    private func prepareWebView() {
        
        let webViewConfiguration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.frame = view.bounds
        
        view.addSubview(webView)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
    }
    
    private func layoutUI() {
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(navigationBar)
        navigationBar.layer.zPosition = 1
        view.bringSubviewToFront(navigationBar)
        
        NSLayoutConstraint.activate([
            
            navigationBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}

extension WebViewController: WebNavigationDelegate, WKUIDelegate, WKNavigationDelegate {
    
    func didFinishTappingCloseButton() {
        
        setSheetDetentToMedium()

        navigationController?.popViewController(animated: true)
    }
    
    func didFinishTappingBackButton() {
        
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func didFinishTappingForwardButton() {
        
        if webView.canGoForward {
            webView.goForward()
        }
    }
}



