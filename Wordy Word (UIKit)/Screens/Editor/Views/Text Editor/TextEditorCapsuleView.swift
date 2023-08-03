//
//  TextEditorCapsuleView.swift
//  WordyWord (UIKit)
//
//  Created by Michael Caesario on 29/04/23.
//

import UIKit

protocol TextEditorCapsuleViewDelegate: AnyObject {
    func didFinishInputingText(text: String)
    func didFinishPastingText(text: String)
}

class TextEditorCapsuleView: UIView {

    private let textEditor = EditorTextView()
    private let buttonStack = ButtonAndLabelStack()
    private let buttonScrollView = UIScrollView()
    private let pasteButton = PillButtonImageWithText()
    private let characterLabel = PillLabelsWithStroke()
    private let wordLabel = PillLabelsWithStroke()
    private let sentenceLabel = PillLabelsWithStroke()
    private let paragraphLabel = PillLabelsWithStroke()
    
    private var characterCount = 0 {
        didSet {
            characterLabel.updateTextLabel(label: characterCount > 1 ? "\(characterCount) Characters" : "\(characterCount) Character" )
        }
    }
    
    private var wordCount = 0 {
        didSet {
            wordLabel.updateTextLabel(label: wordCount > 1 ? "\(wordCount) Words" : "\(wordCount) Word" )
        }
    }
    
    private var sentenceCount = 0 {
        didSet {
            sentenceLabel.updateTextLabel(label: sentenceCount > 1 ? "\(sentenceCount) Sentences" : "\(sentenceCount) Sentence" )
        }
    }
    
    private var paragraphCount = 0 {
        didSet {
            paragraphLabel.updateTextLabel(label: paragraphCount > 1 ? "\(paragraphCount) Paragraphs" : "\(paragraphCount) Paragraph" )
        }
    }
    
    private var editingText = "" {
        didSet {
            delegate?.didFinishInputingText(text: editingText)
        }
    }
    
    private let editorPlaceholderText = "Enter or paste your text here"
    
    weak var delegate: TextEditorCapsuleViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        prepareViews()
        layoutUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareViews() {
                
        textEditor.text = editorPlaceholderText
        textEditor.textColor = .text.placeholder
                
        pasteButton.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        pasteButton.setTitleColor(.text.white, for: .normal)
        pasteButton.setImage(UIImage(systemName: "doc.on.clipboard"), for: .normal)
        pasteButton.setTitle("Paste", for: .normal)
        pasteButton.tintColor = .text.white
        pasteButton.backgroundColor = .button.paste
        pasteButton.setTitleColor(.text.white, for: .normal)
        
        buttonScrollView.alwaysBounceHorizontal = true
        buttonScrollView.showsHorizontalScrollIndicator = false
        
        let labelInsets = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
        
        characterLabel.prepareLabel(labelText: "0 Character", color: .text.black, labelInsets: labelInsets)
        wordLabel.prepareLabel(labelText: "0 Word", color: .text.black, labelInsets: labelInsets)
        sentenceLabel.prepareLabel(labelText: "0 Sentence", color: .text.black, labelInsets: labelInsets)
        paragraphLabel.prepareLabel(labelText: "0 Paragraph", color: .text.black, labelInsets: labelInsets)
    }
    
    private func configureView() {
        
        self.backgroundColor = .background.quarternary
        self.layer.cornerRadius = 50
        self.layer.masksToBounds = true
        
        textEditor.delegate = self
    }
    
    private func layoutUI() {
        
        textEditor.translatesAutoresizingMaskIntoConstraints = false
        
        buttonScrollView.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        pasteButton.translatesAutoresizingMaskIntoConstraints = false
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        sentenceLabel.translatesAutoresizingMaskIntoConstraints = false
        paragraphLabel.translatesAutoresizingMaskIntoConstraints = false
                
        buttonStack.insertArrangedSubview(pasteButton, at: 0)
        buttonStack.insertArrangedSubview(characterLabel, at: 1)
        buttonStack.insertArrangedSubview(wordLabel, at: 2)
        buttonStack.insertArrangedSubview(sentenceLabel, at: 3)
        buttonStack.insertArrangedSubview(paragraphLabel, at: 4)
        
        buttonScrollView.addSubview(buttonStack)

        self.addSubview(textEditor)
        self.addSubview(buttonScrollView)
        
        let padding = 8.0
        
        NSLayoutConstraint.activate([
        
            textEditor.topAnchor.constraint(equalTo: self.topAnchor),
            textEditor.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textEditor.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textEditor.heightAnchor.constraint(equalToConstant: 250),
            
            buttonScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            buttonScrollView.heightAnchor.constraint(equalToConstant: 60),

            buttonStack.topAnchor.constraint(equalTo: buttonScrollView.topAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: buttonScrollView.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: buttonScrollView.trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: buttonScrollView.bottomAnchor),

            characterLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor, multiplier: 0.9),
            wordLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor, multiplier: 0.9),
            sentenceLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor, multiplier: 0.9),
            paragraphLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor, multiplier: 0.9),
            
            pasteButton.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor, multiplier: 0.9),
            pasteButton.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func didTappedPasteButton() {
        
        guard let pasteboardData = UIPasteboard.general.string else { return }
        
        textEditor.text = pasteboardData
        delegate?.didFinishPastingText(text: pasteboardData)
    }
    
    private func calculateText(text: String) {
        
        characterCount = text.count
        wordCount = text.wordCount
        sentenceCount = text.sentenceCount
    }
}

extension TextEditorCapsuleView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // dismiss the keyboard when the user tap return on the keyboard
        if(text == "\n") {
            textEditor.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        // Remove textview placeholder and switch the text font color to normal when the user begins editing inside the textview
        if textView.text == editorPlaceholderText {
            textView.text = ""
            textView.textColor = .text.editor
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("TEXT HAS CHANGED")
        
        /*
            if the texview value changed and textview color is not in placeholder color,
            set the textview value to editing text variable
        */
//        if textView.textColor != .text.placeholder {
//            editingText = textView.text
//        }
        
        calculateText(text: textView.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("EDITING ENDS")
        
        /*
         if textview text is empty when the user ends editing inside the textview,
         set placeholder text for the textview and switch back the text color on the textview to placeholder color
         */
        if textView.text == "" {
            textView.text = editorPlaceholderText
            textView.textColor = .text.placeholder
        }
        
        /*
         if the textview text color is not in placeholder color
         run editing text method
         */
        if textView.textColor != .text.placeholder {
            editingText = textView.text
        }
    }
}
