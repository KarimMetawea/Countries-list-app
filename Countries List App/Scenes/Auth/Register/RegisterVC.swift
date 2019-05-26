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
import JGProgressHUD



class RegisterVC: UIViewController {
    
    
//    outletts
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
//    properties
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .light)
        hud.interactionType = .blockAllTouches
        return hud
    }()
   
// lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setGoogleButtonDelegates()
        validateTextFields()
       

        
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
    
    @IBAction func haveAccountPressed(_ sender: AnyObject) {
        let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LogInVC") as! LogInVC
        navigationController?.pushViewController(vc, animated: true)
    }

  

    
    
    
    @IBAction func signUpButtonPressed(_ sender: AnyObject) {
        
    guard
        emailTextField.hasValue,emailTextField.emailIsValid, let email = emailTextField.text else {return}
        
    guard    passwordTextField.hasValue,passwordTextField.validateMinCharecterCount,confirmPasswordTextField.passwordMatch(password: passwordTextField.text),let password = confirmPasswordTextField.text else {return}
        
        hud.textLabel.text = "loading"
        hud.show(in: view, animated: true)
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("error\(error.localizedDescription)")
            self.hud.textLabel.text = "error"
            self.hud.dismiss(afterDelay: 1)
            }
            print("success:\(user?.user.uid ?? "")")
            self.hud.dismiss()
            self.navigateToCountriesVc()
        }
    }
    
    
    
    @IBAction func facebookButtonPressed(_ sender: Any) {
        self.hud.textLabel.text = "loading"
        self.hud.show(in: view, animated: true)
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile,.email], viewController: self) { (result) in
            switch result {
            
            case .success(_, _, let token):
                let credentials = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                Auth.auth().signIn(with: credentials, completion: { (user, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        self.hud.textLabel.text = "error"
                        self.hud.dismiss(afterDelay: 1)
                        return
                    }
                    DispatchQueue.main.async {
                        self.hud.dismiss()
                        self.navigateToCountriesVc()
                    print("logged in with facebook")
                    }
                })
            case .cancelled:
                self.hud.dismiss()
            case .failed(let error):
                print("error logging in with facebook\(error.localizedDescription)")
                self.hud.textLabel.text = "error"
                self.hud.dismiss(afterDelay: 1)
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
    
    func navigateToCountriesVc(){
        let storyboard = UIStoryboard(name: "CountriesVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CountriesVC") as! CountriesVC
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension RegisterVC :  GIDSignInUIDelegate,GIDSignInDelegate{
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        navigateToCountriesVc()
    }
    
//    setup delegate
    func setGoogleButtonDelegates(){
         GIDSignIn.sharedInstance()?.delegate = self
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
    
    func emptyTextFields(){
        emailTextField.text = nil
        emailTextField.rightViewMode = .never
        emailTextField.layer.borderColor = UIColor.accentColor.cgColor
        passwordTextField.text = nil
        passwordTextField.rightViewMode = .never
        passwordTextField.layer.borderColor = UIColor.accentColor.cgColor
        confirmPasswordTextField.text = nil
        confirmPasswordTextField.rightViewMode = .never
        confirmPasswordTextField.layer.borderColor = UIColor.accentColor.cgColor
    }
}
