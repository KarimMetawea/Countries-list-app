//
//  LogInVc.swift
//  Countries List App
//
//  Created by karim metawea on 5/23/19.
//  Copyright © 2019 KarimMetawea. All rights reserved.
//

import UIKit

class LogInVc: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpViews()
        // Do any additional setup after loading the view.
    }
    

  
    
    func setUpViews(){
        emailTextField.setLeftPaddingPoints(20)
        passwordTextField.setLeftPaddingPoints(20)
        emailTextField.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        passwordTextField.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        logInButton.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        logInButton.layer.borderColor = UIColor.tintColor.cgColor
        
    }

}


extension LogInVc : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
       
        
        if textField == passwordTextField{
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
}
