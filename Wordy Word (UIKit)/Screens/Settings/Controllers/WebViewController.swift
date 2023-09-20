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
//        goToWeb(withURL: url)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goToWeb(withURL: url)
    }
    
    deinit {
        
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack))
        print("DEINTILIZE WEBVIEW")
    }
    
    private func goToWeb(withURL: URL) {
        
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
}

extension WebViewController {
    
    private func configureView() {
        
        view.backgroundColor = .background.primary
        
        navigationController?.isNavigationBarHidden = true
        
        navigationBar.delegate = self
    }
    
    private func prepareWebView() {
        
        let webViewConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.frame = view.bounds
        
        view.addSubview(webView)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
    }
    
    private func layoutUI() {
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
//        webView.translatesAutoresizingMaskIntoConstraints = false
        
//        let views = [navigationBar, webView]
        
        view.addSubview(navigationBar)
        navigationBar.layer.zPosition = 1
        view.bringSubviewToFront(navigationBar)
        
        NSLayoutConstraint.activate([
            
            navigationBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 75),
//
//            webView.topAnchor.constraint(equalTo: view.topAnchor),
//            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100),
//            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension WebViewController: WebNavigationDelegate, WKUIDelegate, WKNavigationDelegate {
    
    func didFinishTappingCloseButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didFinishTappingBackButton() {
        webView.goBack()
    }
    
    func didFinishTappingForwardButton() {
        webView.goForward()
    }
    
}

protocol WebNavigationDelegate: AnyObject {
    
    func didFinishTappingCloseButton()
    func didFinishTappingBackButton()
    func didFinishTappingForwardButton()
}

final class WebNavigation: UIView {
    
    private let gradientBackground = CAGradientLayer()
    private let closeButton = NavigationBarCircleButton()
    private let backButton = NavigationBarCircleButton()
    private let forwardButton = NavigationBarCircleButton()

    weak var delegate: WebNavigationDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        closeButton.setImageForButton(imageName: "xmark", size: 22)
        backButton.setImageForButton(imageName: "chevron.left", size: 22)
        forwardButton.setImageForButton(imageName: "chevron.right", size: 22)
        
        backButton.tintColor = .text.grey
        backButton.isEnabled = false
        
        forwardButton.tintColor = .text.grey
        forwardButton.isEnabled = false
        
        closeButton.addTarget(self, action: #selector(didTappedBackButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTappedBackButton), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(didTappedForwardButton), for: .touchUpInside)
    }
    
    private func layoutUI() {
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews([closeButton, backButton, forwardButton])
        
        let padding = 16.0
        let forwardAndBackSpacing = 10.0
        let multiplierValue = 0.8
        
        NSLayoutConstraint.activate([
        
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            closeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            closeButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            closeButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            
            forwardButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            forwardButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            forwardButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            forwardButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            
            backButton.trailingAnchor.constraint(equalTo: forwardButton.leadingAnchor, constant: -forwardAndBackSpacing),
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue),
            backButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplierValue)

        ])
    }
    
    @objc private func didTappedCloseButton() {
        print("CLOSE BUTTON TAPPED")
        delegate?.didFinishTappingCloseButton()
    }
    
    @objc private func didTappedBackButton() {
        print("BACK BUTTON TAPPED")

        delegate?.didFinishTappingBackButton()
    }
    
    @objc private func didTappedForwardButton() {
        print("FORWARD BUTTON TAPPED")

        delegate?.didFinishTappingForwardButton()
    }
    
    func isBackButtonEnabled(isEnabled: Bool) {
        
        if isEnabled {
            backButton.tintColor = .text.white
            backButton.isEnabled = true
        } else {
            backButton.tintColor = .text.grey
            backButton.isEnabled = false
        }
    }
    
    func isForwardButtonEnabled(isEnabled: Bool) {
        
        if isEnabled {
            forwardButton.tintColor = .text.white
            forwardButton.isEnabled = true
        } else {
            forwardButton.tintColor = .text.grey
            forwardButton.isEnabled = false
        }
    }
}

