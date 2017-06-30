//
//  PUMEmailView.swift
//  popup
//
//  Created by Javan Chen on 2017/6/30.
//  Copyright © 2017年 Javan Chen. All rights reserved.
//

import UIKit

class PMEmailView: UIView {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emilButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didClickButton(_ sender: UIButton) {
        print("Send Email")
    }
}
