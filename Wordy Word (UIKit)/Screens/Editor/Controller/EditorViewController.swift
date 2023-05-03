//
//  ViewController.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 01/05/23.
//

import UIKit

class EditorViewController: UIViewController {

    private let editorNavBar = EditorNavigationBar()
    private let editorPillStack = TextEditorCapsuleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        layoutUI()
    }

    private func configureView() {
        
        view.backgroundColor = .background.primary
        editorNavBar.delegate = self
    }
    
    private func layoutUI() {
        
        editorNavBar.translatesAutoresizingMaskIntoConstraints = false
        editorPillStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(editorNavBar)
//        view.addSubview(editorPillStack)
        
        let horizontalPadding = 18.0
//        let verticalPadding = 12.0
        
        NSLayoutConstraint.activate([
            
            editorNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editorNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            editorNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
            editorNavBar.heightAnchor.constraint(equalToConstant: 60)
            
//            editorPillStack.topAnchor.constraint(equalTo: editorNavBar.bottomAnchor, constant: verticalPadding),
//            editorPillStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
//            editorPillStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
//            editorPillStack.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension EditorViewController: EditorNavigationBarDelegate {
    
    func didTapMenuButton() {
        print("MENU BUTTON TAPPED")
    }
    
}
