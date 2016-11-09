//
//  TSUIAlertAction.swift
//  N-Students
//
//  Created by 王木木 on 16/11/9.
//  Copyright © 2016年 E-edu Space. All rights reserved.
//

import UIKit

class HJAlertActionView: UIView {
    
    private var buttonArray: [String] = []
    
    private var cancel: String = ""
    
    private var allHeight: Int = 0
    
    private let buttonHeight: Int = 44
    
    private let blankHeight: Int = 10
    
    private let cornerRadius: CGFloat = 5
    
    private let btnTag: Int = 100
    
    private let bearingView: UIView = UIView()
    
    internal var buttonHandler: ((Int) -> Void)?
    
    private let animationTime = 0.3
    
    private let selfAlpha: CGFloat = 0.2
    
    private let mainScreenHeight = UIScreen.main.bounds.height
    
    private let btnWidth: Int = Int(UIScreen.main.bounds.width ) - 20
    
    init(buttonArray: [String] = [], cancel: String = "") {
        
        super.init(frame: UIScreen.main.bounds)
        
        let KeyWindow = UIApplication.shared.keyWindow
        
        KeyWindow?.addSubview(self)
    
        self.backgroundColor = UIColor.init(white: 0, alpha: 0)
        
        self.buttonArray = buttonArray
        
        self.cancel = cancel
        
        if buttonArray.isEmpty && cancel.isEmpty { return } else {
            
            allHeight = buttonArray.count - 1
            
        }
        
        allHeight = buttonArray.count * buttonHeight
        
        if cancel.isEmpty { allHeight += blankHeight }else {
            
            allHeight += blankHeight * 2 + buttonHeight
            
        }
        
        self.bearingView.frame = self.bounds
        
        self.bearingView.frame.origin.y = mainScreenHeight
        
        self.addSubview(self.bearingView)
        
        self.bearingView.backgroundColor = UIColor.clear
        
        if !buttonArray.isEmpty {
            
            let bootomView = UIView()
            
            bootomView.layer.masksToBounds = true
            
            bootomView.layer.cornerRadius =  cornerRadius
            
            bootomView.backgroundColor = UIColor.brown
            
            self.bearingView.addSubview(bootomView)
            
            let viewDistance = allHeight - buttonHeight * buttonArray.count
            
            let viewHeight = buttonHeight * buttonArray.count
            
            let bootomViewY = Int(mainScreenHeight) - viewDistance - viewHeight
            
            bootomView.frame = CGRect(x: CGFloat(blankHeight), y: CGFloat(bootomViewY), width: CGFloat(btnWidth), height: CGFloat(viewHeight))
            
            for (index, value) in buttonArray.enumerated() {
                
                let btn = UIButton()
                
                bootomView.addSubview(btn)
                
                setBtnAttribute(btn: btn, title: value)
                
                btn.tag = index + btnTag
                
                btn.addTarget(self, action: #selector(self.touchBtn), for: .touchUpInside)
                
                let distance = buttonHeight * index + index
                
                btn.frame = CGRect(x: 0, y: distance, width: btnWidth, height: buttonHeight)
                
            }
            
        }
        
        if !cancel.isEmpty {
            
            let cancelBtn = UIButton()
            
            self.bearingView.addSubview(cancelBtn)
            
            cancelBtn.layer.masksToBounds = true
            
            cancelBtn.layer.cornerRadius = cornerRadius
            
            cancelBtn.addTarget(self, action: #selector(self.touchCancelBtn), for: .touchUpInside)
            
            setBtnAttribute(btn: cancelBtn, title: cancel)
            
            let cancelBtnTop = Int(mainScreenHeight) - buttonHeight - blankHeight
            
            cancelBtn.frame = CGRect(x: blankHeight, y: cancelBtnTop, width: btnWidth, height: buttonHeight)
            
        }
        
        self.showView()
        
    }
    
    func setBtnAttribute(btn: UIButton ,title: String) {
        
        btn.setTitle(title, for: .normal)
        
        btn.setTitleColor(UIColor.black, for: .normal)
        
        let normalImage = UIColor.generatePureColorUIImage(UIColor.white)
        
        btn.setBackgroundImage(normalImage(), for: .normal)
        
        let selectImage = UIColor.generatePureColorUIImage(UIColor.orange)
        
        btn.setBackgroundImage(selectImage(), for: .highlighted)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.diss()
        
    }
    
    func touchBtn(btn: UIButton) {
        
        let index = btn.tag - btnTag
        
        buttonHandler?(index)
        
    }
    
    func touchCancelBtn() {
        
        UIView.animate( withDuration: animationTime, animations: {
            
            self.bearingView.frame.origin.y = self.mainScreenHeight
            
            self.backgroundColor = UIColor.init(white: 0, alpha: 0)
            
        }) { _ in
            
            self.removeFromSuperview()
            
        }
        
    }
    
    func showView(){
        
        UIView.animate( withDuration: animationTime, animations: {
            
            self.backgroundColor = UIColor.init(white: 0, alpha: self.selfAlpha)
            
            self.bearingView.frame.origin.y = 0
            
        })
        
    }
    
    func diss(){
        
        self.touchCancelBtn()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIColor {
    
    func generatePureColorUIImage() -> UIImage {
        
        let rect = UIScreen.main.bounds
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(self.cgColor)
        
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
}

