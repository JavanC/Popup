//
//  PopupControllerViewController.swift
//  popup
//
//  Created by Javan Chen on 2017/6/16.
//  Copyright © 2017年 Javan Chen. All rights reserved.
//

import UIKit

class PopupController: PopupBaseController {

    private var imageView: UIImageView?
    private var messageView: UIView?
    
    private var messageAttributes = [TextAttribute]()
    private struct TextAttribute {
        var text: String
        var key: String
        var value: Any
    }

    var messageViewWidth: CGFloat { return self.popupWidth - self.horizontalPadding * 2 }
    let minContentHeight: CGFloat = 174
    
    // MARK: - Initial

    func setupImage(name: String) {
        guard let image = UIImage(named: name) else { return }
        self.imageView = UIImageView(image: image)
        self.imageView?.frame.size = CGSize(width: 100, height: 100)
    }
    
    func setupMessageView(view: UIView) {
        self.messageView = view
    }
    
    func addMeesageAttributed(text: String, with value: Any, for key: String) {
        self.messageAttributes.append(TextAttribute(text: text, key: key, value: value))
    }
    
    func addMessageUnderlineAttributed(text: String) {
        self.addMeesageAttributed(text: text, with: NSUnderlineStyle.styleSingle.rawValue, for: NSUnderlineStyleAttributeName)
    }
    
    func addMessageSizeAttributed(text: String, size: CGFloat) {
        self.addMeesageAttributed(text: text, with: messageFont.withSize(size), for: NSFontAttributeName)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        // Setup 'color' for popup
        self.titleColor   = UIColorFromHex(0x434F5A)
        self.messageColor = UIColorFromHex(0x8A8B87)
        self.defaultColor = UIColorFromHex(0x76C9CF)
        self.cancelColor  = UIColorFromHex(0xA3A49F)
        
        // Setup 'stackView'
        let stackView = UIStackView()
        let stackViewWidth = popupWidth - horizontalPadding * 2
        var stackViewHeigh:CGFloat = 0
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = spacing
        
        // Setup 'image' If need
        if let imageView = imageView {
            self.constraintFrameSize(view: imageView)
            stackView.addArrangedSubview(imageView)
            stackViewHeigh += imageView.frame.height + spacing
        }
        
        // Setup 'title' If need
        if let title = title {
            let titleLabel = self.sizeToFitLabel(text: title, width: stackViewWidth, font: titleFont)
            titleLabel.textColor = titleColor
            self.constraintFrameSize(view: titleLabel)
            stackView.addArrangedSubview(titleLabel)
            stackViewHeigh += titleLabel.frame.height + spacing
        }
        
        // Setup 'line' if has no image
        if imageView == nil {
            let line = UIView(frame: CGRect(origin: .zero, size: CGSize(width: stackViewWidth, height: 0.5)))
            line.backgroundColor = UIColor.gray
            self.constraintFrameSize(view: line)
            stackView.addArrangedSubview(line)
            stackViewHeigh += line.frame.height + spacing
        }
        
        // Setup 'message' If need
        if let messageView = messageView {
            messageView.frame = CGRect(origin: .zero, size: CGSize(width: stackViewWidth, height: messageView.frame.height))
            self.constraintFrameSize(view: messageView)
            stackView.addArrangedSubview(messageView)
            stackViewHeigh += messageView.frame.height
        } else if let message = message {
            let messageLabel = self.sizeToFitLabel(text: message, width: stackViewWidth, font: messageFont)
            messageLabel.textColor = messageColor
            self.setupAttributes(label: messageLabel, attrubutes: messageAttributes)
            self.constraintFrameSize(view: messageLabel)
            stackView.addArrangedSubview(messageLabel)
            stackViewHeigh += messageLabel.frame.height
        }
        
        // setup 'spacing' if need
        if stackViewHeigh + verticalPadding * 2 < minContentHeight {
            let spacing = minContentHeight - (stackViewHeigh + verticalPadding * 2)
            let spacingView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: stackViewWidth, height: spacing)))
            self.constraintFrameSize(view: spacingView)
            stackView.addArrangedSubview(spacingView)
            stackViewHeigh += spacingView.frame.height
        }
        
        // Setup 'contentView'
        let contentView = UIView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        contentView.frame.size = CGSize(width: self.popupWidth, height: stackViewHeigh + verticalPadding * 2)
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        self.setupContenView(view: contentView)

        // Setup 'Popup Base Controller'
        super.viewDidLoad()
    }
    
    // MARK: - Constraint View with View Frame Size
    
    private func constraintFrameSize(view: UIView) {
        view.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        view.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    // MARK: - Setup Label Attributes
    
    private func setupAttributes(label: UILabel, attrubutes: [TextAttribute]) {
        guard let text = label.text else { return }

        let mutableAttributedString = NSMutableAttributedString(string: text)
        for messageAttribute in attrubutes {
            let range = (text as NSString).range(of: messageAttribute.text)
            mutableAttributedString.addAttribute(messageAttribute.key, value: messageAttribute.value, range: range)
        }
        label.attributedText = mutableAttributedString
        label.sizeToFit()
    }
}
