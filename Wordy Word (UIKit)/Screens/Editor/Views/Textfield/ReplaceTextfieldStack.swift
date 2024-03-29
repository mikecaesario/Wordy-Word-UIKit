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
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        findTextfield.delegate = self
        replaceTextfield.delegate = self
                
        findTextfield.placeholder = "Find text"
        findTextfield.tintColor = .accent
        replaceTextfield.placeholder = "Replace with"
        replaceTextfield.tintColor = .accent
        
        textfieldStack.axis = .horizontal
        textfieldStack.distribution = .fillEqually
        textfieldStack.spacing = 10
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
    
    private func animateTextfieldColor(textfield: UITextField, isHighlighted: Bool) {
        
        if isHighlighted {
            
            UIView.animate(withDuration: 0.2) {
                textfield.backgroundColor = .background.quarternary
                textfield.textColor = .text.black
            }
        } else {
            
            UIView.animate(withDuration: 0.2) {
                textfield.backgroundColor = .background.secondary
                textfield.textColor = .text.white
            }
        }
    }
    
    func resetTextfields() {
        findText = nil
        findTextfield.text = nil
        replaceTextWith = nil
        replaceTextfield.text = nil
    }
}

extension ReplaceTextfieldStack: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case findTextfield:
            
            if !replaceTextfield.hasText {
                
                replaceTextfield.becomeFirstResponder()
            } else {
                self.endEditing(true)
            }
        case replaceTextfield:
            
            if !findTextfield.hasText {
                
                findTextfield.becomeFirstResponder()
            } else {
                
                self.endEditing(true)
            }
        default: break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
            
        case findTextfield:
            
            if textField.hasText && textField.text != findText {
                findText = textField.text
            }
            
            animateTextfieldColor(textfield: findTextfield, isHighlighted: false)
            
        case replaceTextfield:
            
            if textField.hasText && textField.text != replaceTextWith {
                replaceTextWith = textField.text
            }
            
            animateTextfieldColor(textfield: replaceTextfield, isHighlighted: false)
        default:
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField {
            
        case findTextfield:
            
            animateTextfieldColor(textfield: findTextfield, isHighlighted: true)
            
            if !replaceTextfield.hasText {
              
                findTextfield.returnKeyType = .next
            } else {
                
                findTextfield.returnKeyType = .done
            }
        case replaceTextfield:
            
            animateTextfieldColor(textfield: replaceTextfield, isHighlighted: true)
            
            if !findTextfield.hasText {
                
                replaceTextfield.returnKeyType = .next
            } else {
                
                replaceTextfield.returnKeyType = .done
            }
        default:
            break
        }
    }
}
