//
//  ViewController.swift
//  popup
//
//  Created by Javan Chen on 2017/6/13.
//  Copyright © 2017年 Javan Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let longTest:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func click(_ sender: Any) {

//        let alert = UIAlertController(title: "123123123123123123123123123", message: "123123123123123123123123123", preferredStyle: .alert)
//        let aa = UIAlertAction(title: "1234", style: .cancel, handler: nil)
//        let bb = UIAlertAction(title: "22345", style: .default, handler: nil)
//        let cc = UIAlertAction(title: "3456", style: .destructive, handler: nil)
//        let dd = UIAlertAction(title: "4567", style: .destructive, handler: nil)
//
//        alert.addAction(aa)
//        alert.addAction(bb)
//        alert.addAction(cc)
//        alert.addAction(dd)
//        self.present(alert, animated: true, completion: nil)
//        return
        
        let longTitle = "This Title Is Very Very Long Title!!"
        let longMessage = "The AristotleTM App is not connected to the Internet. Some features in the app may not be available. Would you like to setup your Internet connection now?"
        
        let attributedString = NSMutableAttributedString(string: "Want to learn iOS? You should visit the best source of free iOS tutorials!")
        attributedString.addAttribute(NSLinkAttributeName, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 55))

//        let popup = PopupBaseController(title: longTest ? longTitle : "Short Title", message: longTest ? longMessage : "Short Message")
//        popup.setupContenView(view: view)
        let popup = PopupController(title: longTest ? longTitle : "Short Title", message: longTest ? longMessage : "Short Message")
        
        popup.setupImage(name: "img_auth_camera")
        
        popup.addAction(title: "OK", style: .default ,handler: {
            print("OKOKOK")
        })
        popup.addAction(title: "Cancel", style: .cancel) {
            print("Cancel")
        }
//        popup.addAction(title: "hello", style: .default ) {
//            let popup2 = PopupController(title: "ff", message: "asdf")
//            popup2.addAction(title: "OK", style: .default , handler: nil)
//            popup2.show(in: self)
//            print("Hello")
//        }
        
        popup.show(in: self)
    }
}
