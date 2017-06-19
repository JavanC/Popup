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
//        let aa = UIAlertAction(title: "1", style: .default, handler: nil)
//        let bb = UIAlertAction(title: "1", style: .default, handler: nil)
//        let cc = UIAlertAction(title: "1", style: .default, handler: nil)
//        let dd = UIAlertAction(title: "1", style: .default, handler: nil)
//        alert.addAction(aa)
//        alert.addAction(bb)
//        alert.addAction(cc)
//        alert.addAction(dd)
//        alert.message = "123"
//        self.present(alert, animated: true, completion: nil)
//        return
        
        let longTitle = "This Title Is Very Very Long Title!!"
        let longMessage = "The AristotleTM App is not connected to the Internet. Some features in the app may not be available. Would you like to setup your Internet connection now?"
//
//        let vc = PopupBaseController.initial(title: longTest ? longTitle : "Short Title", message: longTest ? longMessage : "Short Message")
//        
        
//        let popup = PopupController.initial(title: "asdfadsf adsfasdf asdf adsfasdf asdf", message: "asdf")
//        let popup = PopupBaseController(title: "asd", message: "asdasd")
//        let popup = PopupBaseController().show
        
        
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 200))
//        view.backgroundColor = UIColor.brown
        
//        popup.setupContenView(view: view)
//        let okAction = PopupAction(title: "OK") {
//            print("OKOKOK")
//        }
//        let cancelAction = PopupAction(title: "Cancel") { 
//            print("Cancel")
//        }
//        let helloAction = PopupAction(title: "thrith") {
//            print("hello")
//        }
//        popup.addAction(action: okAction)
//        popup.addAction(action: cancelAction)
        
//        popup.show(in: self)
//        popup.addAction(action: helloAction)
//        popup.present(in: self)
//        self.present(popup, animated: true, completion: nil)
//        self.navigationController?.pushViewController(popup, animated: true)
        

        let popup = PopupBaseController(title: longTest ? longTitle : "Short Title", message: longTest ? longMessage : "Short Message")
//        popup.setupContenView(view: view)
        popup.addAction(title: "OK", handler: {
            print("OKOKOK")
        })
        popup.addAction(title: "Cancel") { 
            print("Cancel")
        }
//        popup.addAction(title: "hello") {
//            print("Hello")
//        }
        popup.show(in: self)
        
    }

}

