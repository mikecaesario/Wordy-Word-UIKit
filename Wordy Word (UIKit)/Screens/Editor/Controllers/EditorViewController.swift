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
    
    private let historyDataService: HistoryDataService
    private let textEditorService: TextEditorServiceProtocol
    
    private var findText: String?
    private var replaceWithText: String?
    private var removeCharacterArray: [String]?
    private var resultText: String?
    private var historyDataArray: [HistoryItems] = []
    
    private var editingText: String? {
        didSet {
            startEditText(text: editingText, editingStyle: editingStyle, remove: removeCharacterArray, find: findText, replace: replaceWithText)
        }
    }
    
    private var editingStyle: EditingStyleEnum? {
        didSet {
            
            editorNavBar.setNavBarTitle(title: editingStyle)
            rearrangeStacksIfNeeded(style: editingStyle)
            startEditText(text: editingText, editingStyle: editingStyle, remove: removeCharacterArray, find: findText, replace: replaceWithText)
        }
    }
    
    private var historyDataLimit: Int {
        didSet {
            UserDefaults.standard.set(historyDataLimit, forKey: UserDefaultsEnum.maxHistoryDataLimit)
        }
    }
    
    init(historyDataService: HistoryDataService, textEditorService: TextEditorServiceProtocol) {
        self.historyDataService = historyDataService
        self.textEditorService = textEditorService
        historyDataLimit = UserDefaults.standard.integer(forKey: UserDefaultsEnum.maxHistoryDataLimit)
        historyDataArray = historyDataService.fetchHistoryItemsFromJSON()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("MAX HISTORY DATA LIMIT", historyDataLimit)
        setupDelegates()
        configureView()
        layoutUI()
    }
}

// MARK: - View Setup

extension EditorViewController {
    
    private func configureView() {
        
        let screenHeight = CGFloat(view.bounds.height / 8)
        
        view.backgroundColor = .background.primary
        overrideUserInterfaceStyle = .dark
        editorScrollView.alwaysBounceVertical = true
        editorScrollView.showsVerticalScrollIndicator = false
        editorScrollView.contentInset = UIEdgeInsets(top: 75, left: 0, bottom: screenHeight, right: 0)
        
        replaceTexfieldStack.isHidden = true
        removeButtonStack.isHidden = true
        textResultStack.isHidden = true
    }
    
    private func setupDelegates() {
        
        editorNavBar.delegate = self
        textEditorStack.delegate = self
        tabBar.delegate = self
        replaceTexfieldStack.delegate = self
        removeButtonStack.delegate = self
    }
    
    private func layoutUI() {
        
        editorNavBar.translatesAutoresizingMaskIntoConstraints = false
        
        editorScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainEditorStack.translatesAutoresizingMaskIntoConstraints = false
        removeButtonStack.translatesAutoresizingMaskIntoConstraints = false
        replaceTexfieldStack.translatesAutoresizingMaskIntoConstraints = false
        textEditorStack.translatesAutoresizingMaskIntoConstraints = false
        tabBar.translatesAutoresizingMaskIntoConstraints = false

        mainEditorStack.insertArrangedSubview(removeButtonStack, at: 0)
        mainEditorStack.insertArrangedSubview(replaceTexfieldStack, at: 1)
        mainEditorStack.insertArrangedSubview(textEditorStack, at: 2)
        mainEditorStack.insertArrangedSubview(textResultStack, at: 3)
        
        editorScrollView.addSubview(mainEditorStack)
        
        view.addSubview(editorNavBar)
        view.addSubview(editorScrollView)
        view.addSubview(tabBar)
        
        view.bringSubviewToFront(editorNavBar)
        editorScrollView.layer.zPosition = -1

        let horizontalPadding = 32.0
        
        NSLayoutConstraint.activate([
            
            editorNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            editorNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editorNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editorNavBar.heightAnchor.constraint(equalToConstant: 70),
            
            editorScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
            
            textEditorStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            textEditorStack.widthAnchor.constraint(equalTo: editorScrollView.widthAnchor, constant: -horizontalPadding),
            
            textResultStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            textResultStack.widthAnchor.constraint(equalTo: editorScrollView.widthAnchor, constant: -horizontalPadding),
            
            tabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tabBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45),
            tabBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
    }
}

// MARK: - View Transitions

extension EditorViewController {
    
    // hide or unhide view inside of a stackview
    private func hideOrUnhideViewFromMainStack(hide: Bool, view: UIView, stack: UIStackView) {
        
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
        
        editorMenu = EditorStylePickerViewController(currentSelectedStyle: editingStyle)
        
        if let editorMenu = editorMenu {
            
            editorMenu.delegate = self
            editorMenu.modalPresentationStyle = .overFullScreen
            editorMenu.modalTransitionStyle = .crossDissolve
            self.present(editorMenu, animated: true)
        }
    }
    
    private func dismissEditorStylePickerViewController() {
        
        // check if editorMenu exist and not nil
        guard let editorMenu = editorMenu else { return }
        
        // remove the delegates, dismiss the view, and set editorMenu to nil
        editorMenu.delegate = nil
        editorMenu.dismiss(animated: true)
        self.editorMenu = nil
    }
    
    private func rearrangeStacksIfNeeded(style: EditingStyleEnum?) {
        
        guard let style = style else { return }
        
        switch style {
        case .replace:
            
            hideOrUnhideViewFromMainStack(hide: false, view: replaceTexfieldStack, stack: mainEditorStack)
            hideOrUnhideViewFromMainStack(hide: true, view: removeButtonStack, stack: mainEditorStack)
            removeButtonStack.resetRemoveItemsButton()
            removeCharacterArray = nil
        case .remove:
            
            hideOrUnhideViewFromMainStack(hide: true, view: replaceTexfieldStack, stack: mainEditorStack)
            hideOrUnhideViewFromMainStack(hide: false, view: removeButtonStack, stack: mainEditorStack)
            replaceTexfieldStack.resetTextfields()
            replaceWithText = nil
            findText = nil
        default:
            
            hideOrUnhideViewFromMainStack(hide: true, view: replaceTexfieldStack, stack: mainEditorStack)
            hideOrUnhideViewFromMainStack(hide: true, view: removeButtonStack, stack: mainEditorStack)
            removeButtonStack.resetRemoveItemsButton()
            replaceTexfieldStack.resetTextfields()
            removeCharacterArray = nil
            replaceWithText = nil
            findText = nil
        }
    }
    
    private func openViewControllerModal(controller: UIViewController, autoResizeOnScrollEdge: Bool) {
        
        let viewController = controller
        let navigation = UINavigationController(rootViewController: viewController)
        
        if let historyVCSheet = navigation.sheetPresentationController {
            
            historyVCSheet.detents = [.medium(), .large()]
            historyVCSheet.preferredCornerRadius = 40
            historyVCSheet.prefersScrollingExpandsWhenScrolledToEdge = autoResizeOnScrollEdge
            historyVCSheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        
        present(navigation, animated: true)
    }
}

// MARK: - Editor Methods

extension EditorViewController {
    
    private func startEditText(text: String?, editingStyle: EditingStyleEnum?, remove: [String]?, find: String?, replace: String?) {
                
        guard let text = text, text != "", let style = editingStyle else { return }
        
        let haptics = UIImpactFeedbackGenerator(style: .rigid)
        
        do {
            
            let result = try textEditorService.startEditText(text: text, editingStyle: editingStyle, remove: remove, find: find, replace: replace)
            
            hideOrUnhideViewFromMainStack(hide: true, view: textResultStack, stack: mainEditorStack)
            
            resultText = result
            
            historyDataArray = historyDataService.didFinishEditingNowAppendingHistoryItem(history: historyDataArray, editingText: text, editingResult: result, editingStyle: style)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
                
                if let self = self{
                    
                    self.textResultStack.setResultText(result: result)
                    self.hideOrUnhideViewFromMainStack(hide: false, view: textResultStack, stack: mainEditorStack)
                }
            }
            
            haptics.impactOccurred()
            
            print("FINISHED SHOWING RESULTS")
        } catch {
            print("ERROR OCCURRED")
        }
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

extension EditorViewController: ReplaceTextfieldStackDelegate {
    
    func didFinishInputingReplaceText(find: String, replaceWith: String) {
        findText = find
        replaceWithText = replaceWith
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
        
        let historyViewController = HistoryViewController(historyItems: historyDataArray)
        openViewControllerModal(controller: historyViewController, autoResizeOnScrollEdge: true)
    }
    
    func didTappedSettingsButton() {
        
        let settingsViewController = SettingsViewController(savedHistoryValue: historyDataLimit)
        openViewControllerModal(controller: settingsViewController, autoResizeOnScrollEdge: false)
    }
}
