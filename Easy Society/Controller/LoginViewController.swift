//
//  LoginViewController.swift
//  Easy Society
//
//  Created by Nitish on 4/22/19.
//  Copyright © 2019 Nitish. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    

    @IBAction func logInPressed(_ sender: AnyObject) {
        
        if emailTextfield.text == "" || passwordTextfield.text == "" {
            
            myAlert(title: "Missing Field", message: "Please fill all fields")
        
        }
        
        else {
        
            SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                
                
                switch error {
                case .some(let error as NSError) where error.code == AuthErrorCode.wrongPassword.rawValue:
                    print("Wrong password")
                    SVProgressHUD.dismiss()
                    self.myAlert(title: "Wrong Password", message: "The password you've entered is wrong.")
                    
                case .some(let error as NSError) where error.code == AuthErrorCode.userNotFound.rawValue:
                    print("User not Found")
                    SVProgressHUD.dismiss()
                    self.myAlert(title: "User Error", message: "The following user does not exist")
                    
                case .some(let error as NSError) where error.code == AuthErrorCode.networkError.rawValue:
                    SVProgressHUD.dismiss()
                    self.myAlert(title: "Network Error", message: "Unable to connect to server, please check the network connection")
                    
                case .some(let error):
                    print("Login error: \(error.localizedDescription)")
                    SVProgressHUD.dismiss()
                    self.myAlert(title: "Error", message: "Description: \(error.localizedDescription)")
                    
                    
                case .none:
                    print("NO ERRORS")
                }
            }
                
            else{
                
                print("Login Successful")
                self.performSegue(withIdentifier: "goToHomePage", sender: self)
                
            SVProgressHUD.dismiss()
                
                
            }
            
        }
        
    }
    }
    
    //Reset Password button
    
    @IBAction func resetPasswordPressed(_ sender: UIButton) {
        
        passResetAlert(title: "Reset Password", message: "Would you like to send an email to your email address in order to reset password?")
        
    }
    
    
    // Reset Password Function
    
    func resetPassword () {
        
        Auth.auth().sendPasswordReset(withEmail: emailTextfield.text!) { error in
            
            if error != nil {
                
                switch error {
                    
                case .some(let error):
                    print("Login error: \(error.localizedDescription)")
                    SVProgressHUD.dismiss()
                    self.myAlert(title: "Error", message: "Description: \(error.localizedDescription)")
                    
                case .none:
                    print("No errors in the reset process as of now lol")
                    
                }
                
                
            }
            else {
                
                print("Reset Password Initiated")
                self.myAlert(title: "Password Reset Mail Sent", message: "Please check your Email and go through the procedure to reset the password. Once the process is complete, login using the new Password")
                
            }
            
            }

    }
    
    
    
    func myAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //That is one button
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true , completion: nil)
        
    }
    //Password reset Alert Dialogue Box
    func passResetAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //The Button says OK
        alert.addAction(UIAlertAction(title: "Send Email and Reset Password", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            //This checks if the Email Text Field is empty
            if self.emailTextfield.text == "" {
                self.myAlert(title: "Please Input Email", message: "Email ID is required in order to reset the password")
            }
            
            else {
                    //This calls the reset password function
                    self.resetPassword()
                
                }

            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            
        }))
        
        
        
        self.present(alert, animated: true , completion: nil)
        
        
    }
    
    

}
