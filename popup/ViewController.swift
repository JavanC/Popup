//
//  ViewController.swift
//  popup
//
//  Created by Javan Chen on 2017/6/13.
//  Copyright © 2017年 Javan Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var basePopupButton: UIButton!
    @IBOutlet weak var defaultPopupButton: UIButton!
    @IBOutlet weak var customPopupButton: UIButton!
    
    let longTest:Bool = false
    
    var popupTitle:String {
        return longTest ? "This Title Is Very Very Long Title!" : "Short Title!"
    }
    var popupMessage: String {
        return longTest
            ? "This App is not connected to the Internet. Some features in the app may not be available. Would you like to setup your Internet connection now?"
            : "Short Message"
    }

    @IBAction func didClickButton(_ button: UIButton) {
        
        if button == basePopupButton {
            
            // Base Popup
            let popup = PopupBaseController(title: popupTitle, message: popupMessage)
            popup.addAction(title: "OK", style: .default, handler: nil)
            popup.show(in: self)
            
        } else if button == defaultPopupButton {
            
            // Default Popup
            let popup = PopupController(title: popupTitle, message: popupMessage)
            popup.setupImage(name: "img_auth_camera")
            popup.addAction(title: "OK", style: .default ,handler: {
                print("OK")
            })
            popup.addAction(title: "Cancel", style: .cancel) {
                print("Cancel")
            }
            popup.show(in: self)
        
        } else if button == customPopupButton {
            
            // Custom Message Popup
            let popup = PopupCustomController(title: popupTitle, popupMessageView: .PMEmailView)
            popup.addAction(title: "OK", style: .default, handler: nil)
            popup.show(in: self)
        }
    }
}
