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
    private let removeButtonStack = RemoveButtonStack()
    private let replaceTexfieldStack = ReplaceTextfieldStack()
    private let textEditorStack = TextEditorCapsuleView()
    private let textResultStack = TextResultCapsuleView()
    
    private let tabBar = HistoryAndSettingsTabBar()
    private lazy var menu = EditorStyleMenu()
    
    private let historyDataService: HistoryDataService
    
    private var editingText: String? {
        didSet {
            
        }
    }
    
    private var resultText: String? {
        didSet {
            
        }
    }
    
    private var editingStyle: EditingStyleEnum? {
        didSet {
            
        }
    }
    
    private var historyDataArray: [HistoryItems] = []
    
    init(historyDataService: HistoryDataService) {
        self.historyDataService = historyDataService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        removeButtonStack.translatesAutoresizingMaskIntoConstraints = false
        replaceTexfieldStack.translatesAutoresizingMaskIntoConstraints = false
        textEditorStack.translatesAutoresizingMaskIntoConstraints = false
        textResultStack.translatesAutoresizingMaskIntoConstraints = false
        
        tabBar.translatesAutoresizingMaskIntoConstraints = false

        mainEditorStack.insertArrangedSubview(removeButtonStack, at: 0)
        mainEditorStack.insertArrangedSubview(replaceTexfieldStack, at: 1)
        mainEditorStack.insertArrangedSubview(textEditorStack, at: 2)
        mainEditorStack.insertArrangedSubview(textResultStack, at: 3)
        
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
            
            removeButtonStack.heightAnchor.constraint(equalToConstant: 60),
            removeButtonStack.widthAnchor.constraint(equalTo: editorScrollView.widthAnchor),
            
            replaceTexfieldStack.heightAnchor.constraint(equalToConstant: 60),
            replaceTexfieldStack.widthAnchor.constraint(equalTo: editorScrollView.widthAnchor, constant:  -horizontalPadding),
            
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
    
    // hide or unhide view inside of a stackview
    private func hideView(hide: Bool, view: UIView, stack: UIStackView) {
        
        UIView.animate(withDuration: 0.3, delay: 0) {
            view.alpha = hide ? 0 : 1
            view.isHidden = hide
            stack.layoutIfNeeded()
        } completion: { _ in
            view.isHidden = hide
        }
    }
    
    private func presentMenu(view: EditorStyleMenu) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(view)
        view.layer.zPosition = 2
        view.layoutIfNeeded()
        view.delegate = self

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func dismissMenu(view: EditorStyleMenu) {
        
        view.delegate = nil
        view.removeFromSuperview()
    }
}

extension EditorViewController {
    
    private func startEditText(text: String?, editingStyle: EditingStyleEnum?, remove: [String]?, find: String?, replace: String?) {
            
        guard let text = text, text != "", let style = editingStyle else { return }
        
        var result = ""
        
        switch style {
        case .capitalize:
            result = text.capitalized
        case .title:
            result = text.capitalizeSentences()
        case .upper:
            result = text.uppercased()
        case .lower:
            result = text.lowercased()
        case .replace:
            
            guard let find = find, let replace = replace else { return }
            
            result = text.replaceCharacter(find: find, replaceWith: replace)
            
        case .remove:
            
            guard let remove = remove else { return }

            result = text.removeCharacter(remove: remove)
        case .reverse:
            result = String(text.reversed())
        }
        
        resultText = result
        
        historyDataArray = historyDataService.didFinishEditingNowAppendingHistoryItem(history: historyDataArray, editingText: text, editingResult: result, editingStyle: style)
    }
}

extension EditorViewController: EditorStyleMenuDelegate {
    
    func didFinishPickingEditingStyle(style: EditingStyleEnum?) {
        print("FINISHED PICKING EDITOR STYLE: \(style?.rawValue ?? "NONE")")
    }
    
    func didTappedCancelButton() {
        print("CANCEL MENU FROM EDITOR STYLE PICKER TAPPED")
        
        dismissMenu(view: menu)
    }
}

extension EditorViewController: EditorNavigationBarDelegate {
    
    func didTapMenuButton() {
        print("MENU BUTTON TAPPED")
        
        presentMenu(view: menu)
    }
    
}

extension EditorTextView: RemoveButtonStackDelegate {
    
    func didFinishAddingRemovingItem(itemToRemove: [String]) {
        
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
