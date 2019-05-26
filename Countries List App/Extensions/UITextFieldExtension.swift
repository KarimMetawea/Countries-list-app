//
//  UITextFieldExtension.swift
//  Countries List App
//
//  Created by karim metawea on 5/24/19.
//  Copyright © 2019 KarimMetawea. All rights reserved.
//

import UIKit
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.layer.borderColor = UIColor.accentColor.cgColor
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    
    
    var hasValue:Bool {
        
        guard text == "" else {
            self.layer.borderColor = UIColor.accentColor.cgColor
            self.rightViewMode = .never
            return true}
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        label.text = "❗️"
        label.font = UIFont(name: "Avenir", size: 20)
        self.rightView = label
        self.layer.borderColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)

        //            controlling the mode of the view
        self.rightViewMode = .always
        return false
    }
    
    
    
    var validateMinCharecterCount:Bool {
        
        guard (text?.count)! < 6 else {
            self.layer.borderColor = UIColor.accentColor.cgColor
            self.rightViewMode = .never
            return true}
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        label.text = "At Least 6 chr"
        label.font = UIFont(name: "Avenir", size: 12)
        label.textColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
        self.rightView = label
        self.layer.borderColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
        
        //            controlling the mode of the view
        self.rightViewMode = .always
        return false
    }
    
    
    
    
    var emailIsValid:Bool{
        if try! NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: text ?? "" , options: [], range: NSRange(location: 0, length: text!.count )) == nil {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
            label.text = "Enter Valid Email"
            label.font = UIFont(name: "Avenir", size: 12)
            label.textColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
            self.layer.borderColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
            self.rightView = label
           
            
            //            controlling the mode of the view
            self.rightViewMode = .always
            return false
        }
        
        self.layer.borderColor = UIColor.accentColor.cgColor
        self.rightViewMode = .never
        return true
    }
    
    
    
    func passwordMatch(password:String?) -> Bool{
        if self.text == password || password == nil{
            self.layer.borderColor = UIColor.accentColor.cgColor
            self.rightViewMode = .never
            return true
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        label.text = "Not Matching"
        label.font = UIFont(name: "Avenir", size: 12)
        label.textColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.5803921569, green: 0.06666666667, blue: 0, alpha: 1)
        self.rightView = label
        self.rightViewMode = .always
        return false
        
    }
        
    
    
}
