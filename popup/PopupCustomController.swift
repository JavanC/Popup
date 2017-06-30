//
//  PopupCustomController.swift
//  popup
//
//  Created by Javan Chen on 2017/6/30.
//  Copyright © 2017年 Javan Chen. All rights reserved.
//

import UIKit

enum PopupMessageView: String {
    case PMEmailView = "PMEmailView"
}

class PopupCustomController: PopupController {

    private var popupMessageView: PopupMessageView?

    public convenience init(title:String, popupMessageView: PopupMessageView) {
        self.init(title: title, message: nil)
        self.popupMessageView = popupMessageView
    }
    
    override func viewDidLoad() {
        
        // Check customViewName not nil
        guard let popupMessageView = popupMessageView else {
            super.viewDidLoad()
            return
        }
        
        // Setup Message View
        switch popupMessageView {
        case .PMEmailView:
            let emailView = PMEmailView.instantiateFromXib()
            emailView.emailLabel.font = self.messageFont
            self.setupMessageView(view: emailView)
        }
        
        // Setup 'Popup Base Controller'
        super.viewDidLoad()
    }
}
