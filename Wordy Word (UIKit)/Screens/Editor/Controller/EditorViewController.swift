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
    
    private var editorMenu: EditorStylePickerViewController?
    private var historyVC: HistoryViewController?
    
    private let historyDataService: HistoryDataService
    
    private var editingText: String? {
        didSet {
            startEditText(text: editingText, editingStyle: editingStyle, remove: removeCharacterArray, find: findText, replace: replaceWithText)
        }
    }
    
    private var resultText: String?
    private var findText: String?
    private var replaceWithText: String?
    private var removeCharacterArray: [String]?
    
    private var editingStyle: EditingStyleEnum? {
        didSet {
            
            editorNavBar.setNavBarTitle(title: editingStyle)
            
            switch editingStyle {
            case .replace:
                
                hideView(hide: false, view: replaceTexfieldStack, stack: mainEditorStack)
                hideView(hide: true, view: removeButtonStack, stack: mainEditorStack)
                removeButtonStack.resetRemoveItemsButton()
            case .remove:
                
                hideView(hide: true, view: replaceTexfieldStack, stack: mainEditorStack)
                hideView(hide: false, view: removeButtonStack, stack: mainEditorStack)
                replaceTexfieldStack.resetTextfields()
                removeCharacterArray = nil
            default:
                
                hideView(hide: true, view: replaceTexfieldStack, stack: mainEditorStack)
                hideView(hide: true, view: removeButtonStack, stack: mainEditorStack)
                removeButtonStack.resetRemoveItemsButton()
                replaceTexfieldStack.resetTextfields()
                removeCharacterArray = nil
            }

            startEditText(text: editingText, editingStyle: editingStyle, remove: removeCharacterArray, find: findText, replace: replaceWithText)
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

        historyDataArray = historyDataService.fetchHistoryItemsFromJSON()
        
        configureView()
        layoutUI()
    }
}

// MARK: - View Setup

extension EditorViewController {
    
    private func configureView() {
        
        view.backgroundColor = .background.primary
        overrideUserInterfaceStyle = .dark
        editorScrollView.alwaysBounceVertical = true
        editorScrollView.showsVerticalScrollIndicator = false
        
        editorNavBar.delegate = self
        textEditorStack.delegate = self
        tabBar.delegate = self
        
        replaceTexfieldStack.isHidden = true
        removeButtonStack.isHidden = true
        textResultStack.isHidden = true
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
        
        tabBar.layer.zPosition = 0
        editorScrollView.layer.zPosition = -1
        
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
    
    private func presentEditorStylePickerViewController() {
        
        guard editorMenu == nil else { return }
        
        view.endEditing(true)

//        if let historyVC = historyVC {
//            historyVC.dismiss(animated: true)
//            self.historyVC = nil
//        }
        
        editorMenu = EditorStylePickerViewController(currentSelectedStyle: editingStyle)
        
        if let editorMenu = editorMenu {
            
            editorMenu.delegate = self
            editorMenu.modalPresentationStyle = .overFullScreen
            editorMenu.modalTransitionStyle = .crossDissolve
            self.present(editorMenu, animated: true)
        }
    }
    
    private func dismissEditorStylePickerViewController() {
        
        if let menu = editorMenu {
            
            menu.delegate = nil
            menu.dismiss(animated: true)
            editorMenu = nil
        }
    }
}

extension EditorViewController {
    
    private func startEditText(text: String?, editingStyle: EditingStyleEnum?, remove: [String]?, find: String?, replace: String?) {
            
        guard let text = text, text != "", let style = editingStyle else { return }
        
        let haptics = UIImpactFeedbackGenerator(style: .rigid)
        
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
        
        haptics.impactOccurred()
    }
}

extension EditorViewController: EditorStylePickerViewControllerDelegate {
    
    func didFinishPickingEditingStyle(style: EditingStyleEnum?) {
        
        guard let style = style else { return }
        
        editingStyle = style
        dismissEditorStylePickerViewController()
    }
    
    func didTappedCancelButton() {
        dismissEditorStylePickerViewController()
    }
}

extension EditorViewController: EditorNavigationBarDelegate {
    
    func didTapMenuButton() {
        print("MENU BUTTON TAPPED")
        
        presentEditorStylePickerViewController()
    }
}

extension EditorViewController: RemoveButtonStackDelegate {
    
    func didFinishAddingRemovingItem(itemToRemove: [String]) {
        
        removeCharacterArray = itemToRemove
    }
}

extension EditorViewController: TextEditorCapsuleViewDelegate {
    
    func didFinishInputingText(text: String) {
        
        editingText = text
    }
    
    func didFinishPastingText(text: String) {
        
        editingText = text
    }
}

extension EditorViewController: HistoryAndSettingsTabBarDelegate {
    
    func didTappedHistoryButton() {
        
        print("DID TAP HISTORY BUTTON")
        
        openHistoryViewController(historyItems: historyDataArray)
    }
    
    func didTappedSettingsButton() {
        
        print("DID TAP SETTINGS BUTTON")
        
        openSettingsViewController()
    }
   
    private func openHistoryViewController(historyItems: [HistoryItems]) {
        
        let historyVC = HistoryViewController(historyItems: historyItems)
        let navigation = UINavigationController(rootViewController: historyVC)
        
        if let historyVCSheet = navigation.sheetPresentationController {
            
            historyVCSheet.detents = [.medium(), .large()]
            historyVCSheet.preferredCornerRadius = 40
            historyVCSheet.prefersScrollingExpandsWhenScrolledToEdge = true
            historyVCSheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        
        present(navigation, animated: true)
    }
    
    private func openSettingsViewController() {
        
    }
}
