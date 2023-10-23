//
//  PillButtonImageWithText.swift
//  WordyWord (UIKit)
//
//  Created by Michael Caesario on 30/04/23.
//

import UIKit

class PillButtonImageWithText: UIButton {
    
    private let font = AttributeContainer([NSAttributedString.Key.font: UIFont(name: .fonts.poppinsMedium, size: 16)!])
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configure base UIButton styling
    private func configure() {
        
        self.configuration = .filled()
        self.configuration?.cornerStyle = .capsule
        
        self.configuration?.imagePadding = 10
        self.configuration?.imagePlacement = .leading
        
        self.configuration?.titlePadding = 10
        self.configuration?.titleAlignment = .leading
    }
    
    func setupButton(withTitle: String, andImage: String, needBorder: Bool = false, foregroundColor: UIColor?, backgroundColor: UIColor?, borderColor: UIColor? = UIColor.clear) {
        
        guard let foreground = foregroundColor, let backrgound = backgroundColor else { return }

        self.configuration?.title = withTitle
        self.configuration?.image = UIImage(systemName: andImage)
        
        self.configuration?.background.strokeWidth = needBorder ? 1.0 : 0.0
        self.configuration?.background.strokeColor = needBorder ? borderColor : nil
       
        self.configuration?.baseBackgroundColor = backrgound
        self.configuration?.baseForegroundColor = foreground
        self.configuration?.attributedTitle = AttributedString(withTitle, attributes: font)
    }
}
