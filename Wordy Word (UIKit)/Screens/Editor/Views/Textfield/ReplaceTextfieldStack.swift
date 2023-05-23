//
//  ReplaceTextfieldStack.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 23/05/23.
//

import UIKit

protocol ReplaceTextfieldStackDelegate: AnyObject {
    func didFinishInputingReplaceText(find: String, replaceWith: String)
}

class ReplaceTextfieldStack: UIView {

    private let textfieldStack = UIStackView()
    private let findTextfield = PillTextfields()
    private let replaceTextfield = PillTextfields()
    
    private(set) var findText: String? {
        didSet {
            replaceText(find: findText, replaceWith: replaceTextWith)
        }
    }
    
    private(set) var replaceTextWith: String? {
        didSet {
            replaceText(find: findText, replaceWith: replaceTextWith)
        }
    }
    
    weak var delegate: ReplaceTextfieldStackDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        findTextfield.delegate = self
        replaceTextfield.delegate = self
        
        findTextfield.placeholder = "Find text"
        replaceTextfield.placeholder = "Replace with"
        
        textfieldStack.axis = .horizontal
        textfieldStack.distribution = .fillEqually
        textfieldStack.spacing = 10
        textfieldStack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        textfieldStack.isLayoutMarginsRelativeArrangement = true
    }
    
    private func setupUI() {
        
        textfieldStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(textfieldStack)

        textfieldStack.insertArrangedSubview(findTextfield, at: 0)
        textfieldStack.insertArrangedSubview(replaceTextfield, at: 1)
        
        NSLayoutConstraint.activate([
        
            textfieldStack.topAnchor.constraint(equalTo: self.topAnchor),
            textfieldStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textfieldStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textfieldStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func replaceText(find: String?, replaceWith: String?) {
        
        guard let find = find, let replace = replaceWith else { return }
        
        delegate?.didFinishInputingReplaceText(find: find, replaceWith: replace)
    }
    
    func resetTextfields() {
        findText = nil
        findTextfield.text = nil
        replaceTextWith = nil
        replaceTextfield.text = nil
    }
}

extension ReplaceTextfieldStack: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
            
        case findTextfield:
            if let text = textField.text {
                findText = text
            }
        case replaceTextfield:
            if let text = textField.text {
                replaceTextWith = text
            }
        default:
            break
        }
    }
}
