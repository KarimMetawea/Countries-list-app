//
//  LogInVc.swift
//  Countries List App
//
//  Created by karim metawea on 5/23/19.
//  Copyright © 2019 KarimMetawea. All rights reserved.
//

import UIKit
import JGProgressHUD
import Firebase



class LogInVC: UIViewController {

//    outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
//    properties
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.interactionType = .blockAllTouches
        return hud
    }()
    
//    lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyTextFields()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
//    actions
    @IBAction func signUpressed(_ sender: AnyObject) {
    navigationController?.popViewController(animated: true)
    }
    
    
//    logging in
    @IBAction func logInPressed(_ sender: AnyObject) {
        guard emailTextField.hasValue , let email = emailTextField.text ,
              passwordTextField.hasValue , let password = passwordTextField.text else {return}
        
        hud.show(in: view, animated: true)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("error : \(error!.localizedDescription)")
                self.hud.textLabel.text = "error"
                self.hud.dismiss(afterDelay: 1)
                return
            }
            print("success log in")
            self.navigateToCountriesVc()
            self.hud.dismiss()
        }
        
    }

  
//    class functions
    func setUpViews(){
        emailTextField.setLeftPaddingPoints(20)
        passwordTextField.setLeftPaddingPoints(20)
        emailTextField.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        passwordTextField.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        logInButton.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        logInButton.layer.borderColor = UIColor.tintColor.cgColor
        
    }
    
    func navigateToCountriesVc(){
        let storyboard = UIStoryboard(name: "CountriesVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CountriesVC") as! CountriesVC
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension LogInVC : UITextFieldDelegate{
//    delegate methods
    
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
    
    
    
    func emptyTextFields(){
        emailTextField.text = nil
        passwordTextField.text = nil
    }
    
    
}
