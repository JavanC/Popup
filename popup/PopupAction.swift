//
//  PopupAction.swift
//  popup
//
//  Created by Javan Chen on 2017/6/13.
//  Copyright © 2017年 Javan Chen. All rights reserved.
//

import UIKit

public enum PopupActionStyle : Int {
    case `default`
    case cancel
}

class PopupAction: NSObject {
    
    var title: String?
    var style: PopupActionStyle!
    var handler: (() -> Void)?

    init(title: String?, style: PopupActionStyle, handler: (() -> Void)?) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}
