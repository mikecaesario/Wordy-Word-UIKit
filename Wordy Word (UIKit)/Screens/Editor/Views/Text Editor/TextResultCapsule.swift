//
//  TextResultCapsuleView.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 05/05/23.
//

import UIKit

class TextResultCapsule: UIView {

    private let textResult = ResultTextView()
    private let buttonScrollView = UIScrollView()
    private let buttonStack = ButtonAndLabelStack()
    private let copyButton = PillButtonImageWithText()
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
            wordLabel.updateTextLabel(label: wordCount > 1 ? "\(wordCount) Words" : "\(wordCount) Word")
        }
    }
    
    private var sentenceCount = 0 {
        didSet {
            sentenceLabel.updateTextLabel(label: sentenceCount > 1 ? "\(sentenceCount) Sentences" : "\(sentenceCount) Sentence")
        }
    }
    
    private var paragraphCount = 0 {
        didSet {
            paragraphLabel.updateTextLabel(label: paragraphCount > 1 ? "\(paragraphCount) Parahraphs" : "\(paragraphCount) Paragraph")
        }
    }
    
    private var resultText: String? {
        didSet {
            
            if let text = resultText {
                textResult.text = text
                calculateText(text: text)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareView()
        configureView()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextResultCapsule {
    
    private func prepareView() {
        
        let labelInsets = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)

        copyButton.addTarget(self, action: #selector(didTappedCopyButton), for: .touchUpInside)
        copyButton.setupButton(withTitle: "Copy", andImage: "doc.on.doc", foregroundColor: .text.white, backgroundColor: .button.copy)
        
        textResult.text = resultText
        textResult.textColor = .text.white
        
        buttonScrollView.alwaysBounceHorizontal = true
        buttonScrollView.showsHorizontalScrollIndicator = false
        
        characterLabel.prepareLabel(labelText: "0 Character", titleColor: .text.white, borderColor: .text.grey, buttonColor: .background.secondary, labelInsets: labelInsets)
        wordLabel.prepareLabel(labelText: "0 Word", titleColor: .text.white, borderColor: .text.grey, buttonColor: .background.secondary, labelInsets: labelInsets)
        sentenceLabel.prepareLabel(labelText: "0 Sentence", titleColor: .text.white, borderColor: .text.grey, buttonColor: .background.secondary, labelInsets: labelInsets)
        paragraphLabel.prepareLabel(labelText: "0 Paragraph", titleColor: .text.white, borderColor: .text.grey, buttonColor: .background.secondary, labelInsets: labelInsets)
    }
    
    private func configureView() {
        
        self.backgroundColor = .background.secondary
        self.layer.cornerRadius = 45
        self.layer.masksToBounds = true
    }
    
    private func layoutUI() {
        
        buttonScrollView.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        sentenceLabel.translatesAutoresizingMaskIntoConstraints = false
        paragraphLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textResult.translatesAutoresizingMaskIntoConstraints = false
        
        buttonStack.insertArrangedSubview(copyButton, at: 0)
        buttonStack.insertArrangedSubview(characterLabel, at: 1)
        buttonStack.insertArrangedSubview(wordLabel, at: 2)
        buttonStack.insertArrangedSubview(sentenceLabel, at: 3)
        buttonStack.insertArrangedSubview(paragraphLabel, at: 4)
        
        buttonScrollView.addSubview(buttonStack)
        
        self.addSubviews([buttonScrollView, textResult])
        
        textResult.layer.zPosition = -1
        self.bringSubviewToFront(buttonScrollView)
        
        let padding = 16.0

        NSLayoutConstraint.activate([
        
            buttonScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            buttonScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonScrollView.heightAnchor.constraint(equalToConstant: 60),
            
            buttonStack.topAnchor.constraint(equalTo: buttonScrollView.topAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: buttonScrollView.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: buttonScrollView.trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: buttonScrollView.bottomAnchor),
            
            characterLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor),
            wordLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor),
            sentenceLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor),
            paragraphLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor),
            
            copyButton.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor),
            copyButton.widthAnchor.constraint(equalToConstant: 130),
            
            textResult.topAnchor.constraint(equalTo: self.topAnchor),
            textResult.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textResult.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textResult.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func animateCopyButton(sender: PillButtonImageWithText) {
        
        UIView.transition(with: sender, duration: 0.5, options: [.curveEaseIn, .transitionFlipFromBottom]) {

            sender.setupButton(withTitle: "Copied", andImage: "checkmark", needBorder: true, foregroundColor: .text.white, backgroundColor: .background.secondary, borderColor: .text.grey)
        } completion: { _ in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                UIView.transition(with: sender, duration: 0.5, options: [.curveEaseOut, .transitionFlipFromTop]) {
                    
                    sender.setupButton(withTitle: "Copy", andImage: "doc.on.doc", foregroundColor: .text.white, backgroundColor: .button.copy)
                }
            }
        }
    }
}

extension TextResultCapsule {
    
    func setResultText(result: String?) {
        
        guard let result = result else { return }
        
        calculateText(text: result)
        resultText = result
    }
    
    private func calculateText(text: String) {
        
        characterCount = text.count
        wordCount = text.wordCount
        sentenceCount = text.sentenceCount
        paragraphCount = text.paragraphsCount()
    }
    
    @objc private func didTappedCopyButton(sender: PillButtonImageWithText) {
        
        guard let textItemReadyToBeCopiedToClipboard = resultText else { return }
        
        UIPasteboard.general.string = textItemReadyToBeCopiedToClipboard
        animateCopyButton(sender: sender)
    }
}
