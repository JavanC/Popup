//
//  PopupControllerViewController.swift
//  popup
//
//  Created by Javan Chen on 2017/6/16.
//  Copyright © 2017年 Javan Chen. All rights reserved.
//

import UIKit

class PopupController: PopupBaseController {

    var imageView: UIImageView?
    let titleFont = UIFont(name: "Avenir-Medium", size: 20)!
    let messageFont = UIFont(name: "Avenir-Book", size: 14)!
    
    // MARK: - Initial

    func setupImage(name: String) {
        guard let image = UIImage(named: name) else { return }
        self.imageView = UIImageView(image: image)
        self.imageView?.frame.size = CGSize(width: 100, height: 100)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        // Setup 'color' for popup
        self.titleColor     = UIColorFromHex(0x434F5A)
        self.messageColor   = UIColorFromHex(0x8A8B87)
        self.defaultColor   = UIColorFromHex(0x76C9CF)
        self.cancelColor    = UIColorFromHex(0xA3A49F)
        
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
        if let message = message {
            let messageLabel = self.sizeToFitLabel(text: message, width: stackViewWidth, font: messageFont)
            messageLabel.textColor = messageColor
            self.constraintFrameSize(view: messageLabel)
            stackView.addArrangedSubview(messageLabel)
            stackViewHeigh += messageLabel.frame.height
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
    
    private func constraintFrameSize(view: UIView) {
        view.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        view.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
}
