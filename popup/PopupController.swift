//
//  PopupControllerViewController.swift
//  popup
//
//  Created by Javan Chen on 2017/6/16.
//  Copyright © 2017年 Javan Chen. All rights reserved.
//

import UIKit

class PopupController: PopupBaseController {

//    var popupTitle: String?
//    var message: String?

    
    // MARK: - Initial
    
//    static func initial(title: String?, message: String?) -> PopupController {
//        let vc = PopupController()
//        vc.popupTitle = title
//        vc.message = message
//        return vc
//    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: popupWidth, height: 1000))
//        titleLabel.text = popupTitle
//        titleLabel.textAlignment = .center
//        titleLabel.numberOfLines = 0
//        titleLabel.backgroundColor = .green
//        titleLabel.sizeToFit()
//        
//        print(titleLabel.frame)
//        setupContenView(view: titleLabel)
        
        
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: popupWidth, height: <#T##Int#>)
        
        //        self.titleLabel.text = popupTitle
        //        self.setupMessage(message: message)
        //        self.configureButtonView()
        
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
}
