//
//  TextResultCapsuleView.swift
//  Wordy Word (UIKit)
//
//  Created by Michael Caesario on 05/05/23.
//

import UIKit

class TextResultCapsuleView: UIView {

    private let textResult = ResultTextView()
    private let buttonScrollView = UIScrollView()
    private let buttonStack = ButtonAndLabelStack()
    private let copyButton = PillButtonImageWithText()
    private let characterLabel = PillLabelsWithStroke()
    private let wordLabel = PillLabelsWithStroke()
    private let sentenceLabel = PillLabelsWithStroke()
    private let paragraphLabel = PillLabelsWithStroke()
    
    private var characterCount = 0 { didSet { } }
    private var wordCount = 0 { didSet { } }
    private var sentenceCount = 0 { didSet { } }
    private var paragraphCount = 0 { didSet { } }
    
    private var resultText = "" { didSet { textResult.text = resultText } }
    
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

extension TextResultCapsuleView {
    
    private func prepareView() {
        
        let labelInsets = UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)

        copyButton.addTarget(self, action: #selector(didTappedCopyButton), for: .touchUpInside)
        
        textResult.text = resultText
        textResult.textColor = .text.white
                
        copyButton.setTitleColor(.text.white, for: .normal)
        copyButton.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        copyButton.setTitle("Copy", for: .normal)
        
        buttonScrollView.alwaysBounceHorizontal = true
        buttonScrollView.showsHorizontalScrollIndicator = false
        
        characterLabel.insets = labelInsets
        characterLabel.text = "0 Character"
        
        wordLabel.insets = labelInsets
        wordLabel.text = "0 Word"
        
        sentenceLabel.insets = labelInsets
        sentenceLabel.text = "0 Sentence"
        
        paragraphLabel.insets = labelInsets
        paragraphLabel.text = "0 Paragraph"
    }
    
    private func configureView() {
        
        self.backgroundColor = .background.secondary
        self.layer.cornerRadius = 50
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
        
        self.addSubview(buttonScrollView)
        self.addSubview(textResult)
        
        NSLayoutConstraint.activate([
        
            buttonScrollView.topAnchor.constraint(equalTo: self.topAnchor),
            buttonScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonScrollView.heightAnchor.constraint(equalToConstant: 70),
            
            buttonStack.topAnchor.constraint(equalTo: buttonScrollView.topAnchor),
            buttonStack.leadingAnchor.constraint(equalTo: buttonScrollView.leadingAnchor),
            buttonStack.trailingAnchor.constraint(equalTo: buttonScrollView.trailingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: buttonScrollView.bottomAnchor),
            
            characterLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor, multiplier: 0.9),
            wordLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor, multiplier: 0.9),
            sentenceLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor, multiplier: 0.9),
            paragraphLabel.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor, multiplier: 0.9),
            
            copyButton.heightAnchor.constraint(equalTo: buttonScrollView.heightAnchor, multiplier: 0.9),
            copyButton.widthAnchor.constraint(equalToConstant: 130),
            
            textResult.topAnchor.constraint(equalTo: buttonScrollView.bottomAnchor),
            textResult.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textResult.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textResult.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension TextResultCapsuleView {
    
    func setResultText(result: String) {
        resultText = result
    }
    
    @objc private func didTappedCopyButton() {
        
    }
}
