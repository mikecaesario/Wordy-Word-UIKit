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
    private let editorStack = EditorStackView()
    private let buttonScrollview = UIScrollView()
    private let pasteButton = PillButtonImageWithText()
    private let characterLabel = PillLabelsWithStroke()
    private let wordLabel = PillLabelsWithStroke()
    private let sentenceLabel = PillLabelsWithStroke()
    private let paragraphLabel = PillLabelsWithStroke()
    
    private var characterCount = 0 { didSet { } }
    private var wordCount = 0 { didSet { } }
    private var sentenceCount = 0 { didSet { } }
    private var paragraphCount = 0 { didSet { } }
    
    private var editingText = "" { didSet { } }
    
    weak var delegate: TextEditorCapsuleViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
//        prepareViews()
//        layoutUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareViews() {
        
        let labelInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        textEditor.text = "Enter or paste your text here"
        textEditor.textColor = .text.editor
        
        pasteButton.backgroundColor = .button.paste
        pasteButton.setTitleColor(.text.white, for: .normal)
        pasteButton.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        pasteButton.setTitle("Paste", for: .normal)
        
        buttonScrollview.alwaysBounceHorizontal = true
        buttonScrollview.showsHorizontalScrollIndicator = false
        
        characterLabel.insets = labelInsets
        characterLabel.text = "0 Character"
        
        wordLabel.insets = labelInsets
        wordLabel.text = "0 word"
        
        sentenceLabel.insets = labelInsets
        sentenceLabel.text = "0 Sentence"
        
        paragraphLabel.insets = labelInsets
        paragraphLabel.text = "0 Paragraph"
    }
    
    private func configureView() {
        
        self.backgroundColor = .background.quarternary
        self.layer.cornerRadius = 40
        self.layer.masksToBounds = true
    }
    
    private func layoutUI() {
        
        textEditor.translatesAutoresizingMaskIntoConstraints = false
        buttonScrollview.translatesAutoresizingMaskIntoConstraints = false
                
        buttonStack.insertSubview(pasteButton, at: 0)
        buttonStack.insertSubview(characterLabel, at: 1)
        buttonStack.insertSubview(wordLabel, at: 2)
        buttonStack.insertSubview(sentenceLabel, at: 3)
        buttonStack.insertSubview(paragraphLabel, at: 4)
        
        buttonScrollview.addSubview(buttonStack)
        
        editorStack.insertSubview(textEditor, at: 1)
        editorStack.insertSubview(buttonScrollview, at: 2)
        
        self.addSubview(editorStack)
    }
}

extension TextEditorCapsuleView: UITextViewDelegate {
    
}
