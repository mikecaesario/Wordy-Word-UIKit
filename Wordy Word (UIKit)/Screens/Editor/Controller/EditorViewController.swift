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
        editorScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainEditorStack.translatesAutoresizingMaskIntoConstraints = false
        textEditorStack.translatesAutoresizingMaskIntoConstraints = false
        textResultStack.translatesAutoresizingMaskIntoConstraints = false

        mainEditorStack.insertArrangedSubview(textEditorStack, at: 0)
        mainEditorStack.insertArrangedSubview(textResultStack, at: 1)
        
        editorScrollView.addSubview(mainEditorStack)
        
        view.addSubview(editorNavBar)
        view.addSubview(editorScrollView)
        
        let navHorizontalPadding = 18.0
        let navVerticalPadding = 25.0

        let horizontalPadding = 15.0
        let verticalPadding = 10.0
        
        NSLayoutConstraint.activate([
            
            editorNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editorNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: navHorizontalPadding),
            editorNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -navHorizontalPadding),
            editorNavBar.heightAnchor.constraint(equalToConstant: 60),
            
            editorScrollView.topAnchor.constraint(equalTo: editorNavBar.topAnchor),
            editorScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editorScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editorScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainEditorStack.topAnchor.constraint(equalTo: editorScrollView.topAnchor),
            mainEditorStack.leadingAnchor.constraint(equalTo: editorScrollView.leadingAnchor),
            mainEditorStack.trailingAnchor.constraint(equalTo: editorScrollView.trailingAnchor),
            mainEditorStack.bottomAnchor.constraint(equalTo: editorScrollView.bottomAnchor),
            
            textEditorStack.heightAnchor.constraint(equalToConstant: 320),
            textEditorStack.widthAnchor.constraint(equalTo: mainEditorStack.widthAnchor),
            
            textResultStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            textResultStack.widthAnchor.constraint(equalTo: mainEditorStack.widthAnchor)

//            textEditorStack.topAnchor.constraint(equalTo: editorNavBar.bottomAnchor, constant: navVerticalPadding),
//            textEditorStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
//            textEditorStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalPadding),
//            textEditorStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.43)
        ])
    }
}

extension EditorViewController: EditorNavigationBarDelegate {
    
    func didTapMenuButton() {
        print("MENU BUTTON TAPPED")
    }
    
}
