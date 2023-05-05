//
//  ViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 01/05/23.
//

import UIKit

class EditorViewController: UIViewController {

    private let editorNavBar = EditorNavigationBar()
    private let navBarWithRemoveAndReplaceStack = NavBarWithRemoveAndReplaceStack()
    private let textEditorStack = TextEditorCapsuleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        layoutUI()
    }
}

extension EditorViewController {
    
    private func configureView() {
        
        view.backgroundColor = .background.primary
        editorNavBar.delegate = self
    }
    
    private func layoutUI() {
        
        editorNavBar.translatesAutoresizingMaskIntoConstraints = false
        textEditorStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(editorNavBar)
        view.addSubview(textEditorStack)
        
        let navHorizontalPadding = 18.0
        let navVerticalPadding = 20.0

        let horizontalPadding = 13.0
        let verticalPadding = 10.0
        
        NSLayoutConstraint.activate([
            
            editorNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editorNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: navHorizontalPadding),
            editorNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -navHorizontalPadding),
            editorNavBar.heightAnchor.constraint(equalToConstant: 60),
            
            textEditorStack.topAnchor.constraint(equalTo: editorNavBar.bottomAnchor, constant: navVerticalPadding),
            textEditorStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            textEditorStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            textEditorStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.43)
        ])
    }
}

extension EditorViewController: EditorNavigationBarDelegate {
    
    func didTapMenuButton() {
        print("MENU BUTTON TAPPED")
    }
    
}
