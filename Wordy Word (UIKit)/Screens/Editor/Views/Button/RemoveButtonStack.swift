//
//  RemoveButtonStack.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 18/05/23.
//

import UIKit

protocol RemoveButtonStackDelegate: AnyObject {
    func didFinishAddingRemovingItem(itemToRemove: [String])
}

class RemoveButtonStack: UIView {

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceHorizontal = true
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 3
        stack.distribution = .fill
        stack.alignment = .leading
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
        
    private let removeCharacterArray = ["*", "_", "/", "+", "(", ")", "%", "#", "!", "?", "@", "|", "{", "}", ":", ".", ","]
    
    private(set) var pickedRemovedCharacterArray: [String] = []
    
    weak var delegate: RemoveButtonStackDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        
        self.backgroundColor = .clear
        layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func setupUI() {
                
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
                
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        setupButtonArrays()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func setupButtonArrays() {
        
        for i in removeCharacterArray {
            
            if let tag = removeCharacterArray.firstIndex(of: i) {
                
                let button = PillButtonWithStroke()
                button.tag = tag
                button.setTitle(i, for: .normal)
                button.addTarget(self, action: #selector(removeButtonAction), for: .touchUpInside)
                
                button.translatesAutoresizingMaskIntoConstraints = false
                button.heightAnchor.constraint(equalToConstant: 55).isActive = true
                button.widthAnchor.constraint(equalToConstant: 90).isActive = true
                
                stackView.insertArrangedSubview(button, at: tag)
            }
        }
    }
    
    @objc private func removeButtonAction(sender: UIButton) {
        
        let choosenCharacterFromButton = removeCharacterArray[sender.tag]
        
        print(choosenCharacterFromButton)
        
        if pickedRemovedCharacterArray.contains(choosenCharacterFromButton) {
            
            if let index = pickedRemovedCharacterArray.firstIndex(where: { $0 == choosenCharacterFromButton }) {
                
                sender.setTitleColor(.text.grey, for: .normal)
                sender.layer.borderColor = UIColor.button.strokeLight?.cgColor
                sender.backgroundColor = .clear
                pickedRemovedCharacterArray.remove(at: index)
                delegate?.didFinishAddingRemovingItem(itemToRemove: pickedRemovedCharacterArray)
                print(pickedRemovedCharacterArray)
            }
            
        } else {
            
            sender.setTitleColor(.text.black, for: .normal)
            sender.layer.borderColor = UIColor.text.white?.cgColor
            sender.backgroundColor = .text.white
            pickedRemovedCharacterArray.append(choosenCharacterFromButton)
            delegate?.didFinishAddingRemovingItem(itemToRemove: pickedRemovedCharacterArray)
            print(pickedRemovedCharacterArray)
        }
    }
    
    func resetRemoveItemsButton() {
        pickedRemovedCharacterArray = []
        print(pickedRemovedCharacterArray)
        
        for view in self.stackView.subviews as [UIView] {
            if let button = view as? UIButton {
                button.setTitleColor(.text.grey, for: .normal)
                button.backgroundColor = .clear
                button.layer.borderColor = UIColor.button.strokeLight?.cgColor
            }
        }
    }

}
