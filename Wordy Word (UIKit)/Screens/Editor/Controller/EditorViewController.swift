//
//  ViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 01/05/23.
//

import UIKit

class EditorViewController: UIViewController {

    private let editorNavBar = EditorNavigationBar()
    
    private let editorScrollView = UIScrollView()
    private let mainEditorStack = MainEditorStack()
    private let textEditorStack = TextEditorCapsuleView()
    private let textResultStack = TextResultCapsuleView()
    
    private let tabBar = HistoryAndSettingsTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        layoutUI()
    }
}

extension EditorViewController {
    
    private func configureView() {
        
        view.backgroundColor = .background.primary
        editorScrollView.alwaysBounceVertical = true
        editorScrollView.showsVerticalScrollIndicator = false
        
        editorNavBar.delegate = self
        textEditorStack.delegate = self
        tabBar.delegate = self
    }
    
    private func layoutUI() {
        
        editorNavBar.translatesAutoresizingMaskIntoConstraints = false
        
        editorScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainEditorStack.translatesAutoresizingMaskIntoConstraints = false
        textEditorStack.translatesAutoresizingMaskIntoConstraints = false
        textResultStack.translatesAutoresizingMaskIntoConstraints = false
        
        tabBar.translatesAutoresizingMaskIntoConstraints = false

        mainEditorStack.insertArrangedSubview(textEditorStack, at: 0)
        mainEditorStack.insertArrangedSubview(textResultStack, at: 1)
        
        editorScrollView.addSubview(mainEditorStack)
        
        view.addSubview(editorNavBar)
        view.addSubview(editorScrollView)
        view.addSubview(tabBar)
        
        tabBar.layer.zPosition = 1
        editorScrollView.layer.zPosition = 0
        
        let navHorizontalPadding = 18.0
        let navVerticalPadding = 15.0

        let horizontalPadding = 26.0
        
        NSLayoutConstraint.activate([
            
            editorNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editorNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: navHorizontalPadding),
            editorNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -navHorizontalPadding),
            editorNavBar.heightAnchor.constraint(equalToConstant: 60),
            
            editorScrollView.topAnchor.constraint(equalTo: editorNavBar.bottomAnchor, constant: navVerticalPadding),
            editorScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editorScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editorScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainEditorStack.topAnchor.constraint(equalTo: editorScrollView.topAnchor),
            mainEditorStack.leadingAnchor.constraint(equalTo: editorScrollView.leadingAnchor),
            mainEditorStack.trailingAnchor.constraint(equalTo: editorScrollView.trailingAnchor),
            mainEditorStack.bottomAnchor.constraint(equalTo: editorScrollView.bottomAnchor),
            mainEditorStack.widthAnchor.constraint(equalTo: editorScrollView.widthAnchor),
            
            textEditorStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            textEditorStack.widthAnchor.constraint(equalTo: editorScrollView.widthAnchor, constant: -horizontalPadding),

            textResultStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            textResultStack.widthAnchor.constraint(equalTo: editorScrollView.widthAnchor, constant: -horizontalPadding),
            
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tabBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            tabBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
    }
}

extension EditorViewController: EditorNavigationBarDelegate {
    
    func didTapMenuButton() {
        print("MENU BUTTON TAPPED")
    }
    
}

extension EditorViewController: TextEditorCapsuleViewDelegate {
    
    func didFinishInputingText(text: String) {
        
    }
    
    func didFinishPastingText(text: String) {
        
    }
   
}

extension EditorViewController: HistoryAndSettingsTabBarDelegate {
    
    func didTappedHistoryButton() {
        print("DID TAP HISTORY BUTTON")
    }
    
    func didTappedSettingsButton() {
        print("DID TAP SETTINGS BUTTON")
    }
   
}
