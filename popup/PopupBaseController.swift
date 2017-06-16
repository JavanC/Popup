//
//  PopupBaseViewController.swift
//  popup
//
//  Created by Javan Chen on 2017/6/13.
//  Copyright © 2017年 Javan Chen. All rights reserved.
//

import UIKit

class PopupBaseController: UIViewController {

//    @IBOutlet weak var popupView: UIView!
//    @IBOutlet weak var ImageContainerView: UIView!
//    @IBOutlet weak var splitContainerView: UIView!
//    @IBOutlet weak var spliteLine: UIView!
//    @IBOutlet weak var titleLabel: UILabel!
//    var popupTitle: String?
//    var message: String?
    
    private var popupView = UIView()
    private var buttonView = UIView()
    private var contentView = UIView()
    
    public  var popupWidth: CGFloat { return 270.0 }
    private var buttonHeight: CGFloat = 54.0
    private var buttons = [UIButton]()
    public  var actions = [PopupAction]()
    
    // MARK: - initial
//    static func initial(title: String?, message: String?) -> PopupBaseViewController {
//        let storyboard = UIStoryboard(name: "Popup", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PopupBaseViewController") as! PopupBaseViewController
//        vc.popupTitle = title
//        vc.message = message
//        return vc
//    }
    
    func setupContenView(view: UIView) {
        self.contentView.addSubview(view)
        self.contentView.frame = CGRect(x: 0, y: 0, width: popupWidth, height: view.frame.height)
    }
    
    func addAction(action: PopupAction) {
        print("addAction")
        self.actions.append(action)
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.configurePopupView()
        self.configureButtons()

//        self.titleLabel.text = popupTitle
//        self.setupMessage(message: message)
//        self.configureButtonView()
    }
    
    // MARK: - Configure
    func configurePopupView() {
        
        // Step 1: Setup Popup View
        view.addSubview(popupView)

        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.backgroundColor = UIColor.black
        popupView.layer.cornerRadius = 10.0
        popupView.layer.masksToBounds = true
        popupView.addSubview(contentView)
        popupView.addSubview(buttonView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor.red
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = UIColor.blue
        
  
        // Step 2: Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints() {
        
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
        buttonView.topAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        buttonView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor).isActive = true
        
        // NOTE: Calculate bottonView Height by actions count
        let multiplier = (actions.count == 2) ? 1 : CGFloat(actions.count)
        let buttonViewHeight:CGFloat = self.buttonHeight * multiplier
        buttonView.heightAnchor.constraint(equalToConstant: buttonViewHeight).isActive = true
    }
    
    
    /*func setupMessage(message: String?) {
        let width = self.contentView.frame.width
        let content = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 1000))
        content.text = self.message
        content.textAlignment = .center
        content.numberOfLines = 0
        content.sizeToFit()
        content.backgroundColor = UIColor.red
        print(content.frame.height)
        if content.frame.height > self.contentView.frame.height {
            contentViewHeightConstraint.constant = content.frame.height
        }
        contentView.addSubview(content)
    }*/
    
    func configureButtons() {
        
        for (index, action) in actions.enumerated() {
            
            // Calculate button frame
            let isTwoButtonLayout = (actions.count == 2)
            let x      = isTwoButtonLayout && index == 1 ? popupWidth / 2 : 0
            let y      = isTwoButtonLayout ? 0 : CGFloat(index) * buttonHeight
            let width  = isTwoButtonLayout ? popupWidth / 2 : popupWidth
            let height = buttonHeight

            // Setup Button
            let button = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
            button.backgroundColor = .gray
            button.setTitle(action.title, for: .normal)
            button.addTarget(self, action: #selector(didClickButton(_:)), for: .touchUpInside)
            self.buttons.append(button)
            self.buttonView.addSubview(button)
            
            // Setup horizontal line
            let line = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 3))
            line.backgroundColor = UIColor.yellow
            button.addSubview(line)
            
            // Setup Vertical line
            if actions.count == 2 && index == 1 {
                let line = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: height))
                line.backgroundColor = UIColor.yellow
                button.addSubview(line)
            }
        }
    }
    
    func didClickButton(_ sender: UIButton) {
        if let index = buttons.index(of: sender) {
            // Do Handler if need
            if let handler = actions[index].handler {
                handler()
            }
            // Dismiss Popup
            self.navigationController?.popViewController(animated: true)
        }
    }
}
