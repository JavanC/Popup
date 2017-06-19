//
//  PopupAction.swift
//  popup
//
//  Created by Javan Chen on 2017/6/13.
//  Copyright © 2017年 Javan Chen. All rights reserved.
//

import UIKit

class PopupAction: NSObject {
    
    var title: String?
    var handler: (() -> Void)?

    init(title: String?, handler: (() -> Void)? = nil) {
        self.title = title
        self.handler = handler
    }
}
