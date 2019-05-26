//
//  RegisterVc.swift
//  Countries List App
//
//  Created by karim metawea on 5/23/19.
//  Copyright © 2019 KarimMetawea. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class RegisterVC: UIViewController {
    
    
//    outletts
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setGoogleButtonDelegates()
        validateTextFields()
        

        
        // Do any additional setup after loading the view.
    }
    
    
  
    
//    actions
    
    @IBAction func haveAccountPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "ToLogIn", sender: nil)
        
    }

  
    @IBAction func unwindToRegister(_ unwindSegue: UIStoryboardSegue) {
        
//        let sourceViewController = unwindSegue.source
    }
    
    
    
    @IBAction func signUpButtonPressed(_ sender: AnyObject) {
        guard emailTextField.hasValue,emailTextField.emailIsValid, let email = emailTextField.text else {return}
        guard passwordTextField.hasValue,passwordTextField.validateMinCharecterCount,confirmPasswordTextField.passwordMatch(password: passwordTextField.text),let password = confirmPasswordTextField.text else {return}

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("error\(error.localizedDescription)")
            }

            print("success:\(user?.user.uid ?? "")")
        }
    }
    
    
    @IBAction func facebookButtonPressed(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile,.email], viewController: self) { (result) in
            switch result {
            
            case .success(_, _, let token):
                let credentials = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                Auth.auth().signIn(with: credentials, completion: { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    print("logged in with facebook")
                })
            case .cancelled:
                self.dismiss(animated: true, completion: nil)
            case .failed(let error):
                print("error logging in with facebook\(error.localizedDescription)")
            }
        }
    }
    
    
    
    @IBAction func googleButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
//    functions
    
    func setUpViews(){
        
        emailTextField.setLeftPaddingPoints(20)
        passwordTextField.setLeftPaddingPoints(20)
        confirmPasswordTextField.setLeftPaddingPoints(20)
        emailTextField.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        passwordTextField.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        confirmPasswordTextField.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        registerButton.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        registerButton.layer.borderColor = UIColor.tintColor.cgColor
        facebookButton.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        facebookButton.layer.borderColor = UIColor.accentColor.cgColor
        googleButton.roundShapeAndMakeShadow(border: 3, ShadowOffset: .zero)
        googleButton.layer.borderColor = UIColor.accentColor.cgColor
    }

}

extension RegisterVC :  GIDSignInUIDelegate{

    
//    setup delegate
    func setGoogleButtonDelegates(){
        GIDSignIn.sharedInstance().uiDelegate = self
    }

}

extension RegisterVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField == passwordTextField{
            confirmPasswordTextField.becomeFirstResponder()
        }
        
        if textField == confirmPasswordTextField{
        confirmPasswordTextField.resignFirstResponder()
        }
        return true
    }
//    end editing when taping
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
//    validating
    func validateTextFields(){
            emailTextField.addTarget(self, action: #selector(validateEmailTextField(textField:)), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(validatePasswordTextField(textField:)), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(validateConfirmPasswordTextField(textField:)), for: .editingChanged)
        
    }
    
    @objc func validateEmailTextField(textField:UITextField){
        guard textField.hasValue else {return}
        guard textField.emailIsValid else {return}
    }
    
    @objc func validatePasswordTextField(textField:UITextField) {
         guard textField.hasValue else {return}
         guard textField.validateMinCharecterCount else {return}
        
        
         }
    
    @objc func validateConfirmPasswordTextField(textField:UITextField){
        guard textField.passwordMatch(password: passwordTextField.text) else {return}
    }
}
