//
//  PopupBaseViewController.swift
//  popup
//
//  Created by Javan Chen on 2017/6/13.
//  Copyright © 2017年 Javan Chen. All rights reserved.
//

import UIKit

open class PopupBaseController: UIViewController {
    
    private var popupView  = UIView()
    private var buttonView = UIStackView()
    private var contentView: UIView!
    
    let popupWidth: CGFloat         = 270.0
    let buttonHeight: CGFloat       = 54.0
    let verticalPadding:CGFloat     = 34.0
    let horizontalPadding:CGFloat   = 25.0
    let spacing:CGFloat             = 10.0
   
    var titleColor   = UIColorFromHex(0x434F5A)
    var messageColor = UIColorFromHex(0x8A8B87)
    var defaultColor = UIColorFromHex(0x76C9CF)
    var cancelColor  = UIColorFromHex(0xA3A49F)
   
    var actions = [PopupAction]()
    var buttons = [UIButton]()
    var message:String?
    
    // MARK: - Initial
    
    public convenience init(title: String?, message: String?) {
        self.init()
        self.title = title
        self.message = message
    }
    
    public func show(in viewController: UIViewController) {
        definesPresentationContext = true
        modalPresentationStyle = .overFullScreen
        view.alpha = 0.0
        viewController.present(self, animated: false, completion: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            UIView.animate(withDuration: 0.25, animations: {
                self.view.alpha = 1.0
                self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        })
    }

    func addAction(action: PopupAction) {
        self.actions.append(action)
    }
    
    func addAction(title: String?, style: PopupActionStyle, handler: (() -> Void)?) {
        let action = PopupAction(title: title, style: style, handler: handler)
        self.actions.append(action)
    }
    
    func setupContenView(view: UIView) {
        self.contentView = view
    }

    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.configurePopupView()
        self.setupConstraints()
    }
    
    // MARK: - Configure
    
    private func configurePopupView() {
        
        // Setup 'view'
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        view.addSubview(popupView)

        // Setup 'popup view'
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.backgroundColor = UIColor.lightGray
        popupView.layer.cornerRadius = 10.0
        popupView.layer.masksToBounds = true
        
        // Setup 'content view'
        if contentView == nil {
            contentView = defaultContentView()
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.white
        popupView.addSubview(contentView)
        
        // Setup 'buttons'
        for action in actions {
            let button = UIButton()
            button.setTitle(action.title, for: .normal)
            button.addTarget(self, action: #selector(didClickButton(_:)), for: .touchUpInside)
            
            let styleColor = (action.style == .cancel) ? cancelColor : defaultColor
            let buttonColor = UIImage.with(color: styleColor)
            let buttonHighlightColor = UIImage.with(color: adjustBrightness(styleColor, amount: 0.9))
            button.setBackgroundImage(buttonColor, for: .normal)
            button.setBackgroundImage(buttonHighlightColor, for: .highlighted)
            
            self.buttons.append(button)
            self.buttonView.addArrangedSubview(button)
        }
        
        // Setup 'button view'
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.spacing = 1
        buttonView.axis = (buttons.count == 2) ? .horizontal : .vertical
        buttonView.distribution = .fillEqually
        popupView.addSubview(buttonView)
    }
    
    private func setupConstraints() {
        
        // Popup View
        popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        popupView.widthAnchor.constraint(equalToConstant: popupWidth).isActive = true
        
        // Content Viwe
        contentView.topAnchor.constraint(equalTo: popupView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor).isActive = true
        let contentViewHeight:CGFloat = contentView.frame.height
        contentView.heightAnchor.constraint(equalToConstant: contentViewHeight).isActive = true
        
        // Button View
        buttonView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 1).isActive = true
        buttonView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor).isActive = true
        
        // NOTE: Calculate bottonView Height by actions count
        let multiplier = (actions.count == 2) ? 1 : CGFloat(actions.count)
        let buttonViewHeight:CGFloat = self.buttonHeight * multiplier
        buttonView.heightAnchor.constraint(equalToConstant: buttonViewHeight).isActive = true
    }
    
    // MARK: - Action
    
    func didClickButton(_ sender: UIButton) {

        // Close Popup
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: { finished in
            self.dismiss(animated: false, completion: {
                
                // When completion, Do Handler if need.
                if let index = self.buttons.index(of: sender), let handler = self.actions[index].handler {
                    handler()
                }
            })
        })
    }
    
    // MARK: - Default Content View
    
    private func defaultContentView() -> UIView {
        
        let contentWidth = popupWidth - horizontalPadding * 2
        let titleFont = UIFont(name: "Avenir-Medium", size: 20)!
        let messageFont = UIFont(name: "Avenir-Book", size: 14)!
        
        let titleLabel = sizeToFitLabel(text: title, width: contentWidth, font: titleFont)
        titleLabel.backgroundColor = .blue
        titleLabel.textColor = titleColor
        let messageLabel = sizeToFitLabel(text: message, width: contentWidth, font: messageFont)
        messageLabel.backgroundColor = UIColor.brown
        messageLabel.textColor = messageColor
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, messageLabel])
        let stackViewHeight = titleLabel.frame.height + messageLabel.frame.height
        stackView.frame = CGRect(x: horizontalPadding, y: verticalPadding, width: contentWidth, height: stackViewHeight)
        stackView.axis = .vertical
        stackView.spacing = spacing
        
        contentView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: popupWidth, height: stackViewHeight + verticalPadding * 2)))
        contentView.addSubview(stackView)
        
        return contentView
    }
    
    func sizeToFitLabel(text: String? = "", width: CGFloat, font: UIFont) -> UILabel {
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: width, height: 0)))
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }
}
