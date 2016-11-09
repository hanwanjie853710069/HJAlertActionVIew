//
//  ViewController.swift
//  HJAlertActionVIew
//
//  Created by 王木木 on 16/11/9.
//  Copyright © 2016年 王木木. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let bootom = HJAlertActionView(buttonArray: ["韩木木","王木木","两个木木"], cancel: "取消")
        
        bootom.buttonHandler = {
            
            print($0)
            
        }
        
    }
    
}

