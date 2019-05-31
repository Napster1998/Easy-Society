//
//  RegisterViewController.swift
//  Easy Society
//
//  Created by Nitish on 4/24/19.
//  Copyright © 2019 Nitish. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var passwordTextfield2: UITextField!
    @IBOutlet weak var numberTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var flatNumberTextfield: UITextField!
    
    var refUserData: DatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refUserData = Database.database().reference().child("ANDROIDUSERS")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addUserData() {
        let key = refUserData.childByAutoId().key
        
        let userEmail = Auth.auth().currentUser?.email
        
        let UserID = ["User":userEmail,
                      "First Name":firstNameTextField.text! as String, "Last Name":lastNameTextfield.text! as String,
                      "Phone Number:": numberTextfield.text! as String, "Flat Number:":flatNumberTextfield.text! as String]
        
        refUserData.child(key!).setValue(UserID)
        
        
    }
    
    
    
    
    
    
    
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        
        if emailTextfield.text == "" || flatNumberTextfield.text == "" || firstNameTextField.text == "" || lastNameTextfield.text == "" || numberTextfield.text == "" || passwordTextfield.text == "" || passwordTextfield2.text == "" {
            
            myAlert(title: "Missing Fields", message: "Please Fill all fields")
            
        }
        
        
        else {
        
            if passwordTextfield.text != passwordTextfield2.text {
                
                myAlert(title: "Check Password", message: "The entered passwords do not match")
                
            }
        
        else {
                
        SVProgressHUD.show()
    
        
       // Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
                
                Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user,error) in
            
            if error != nil {
                
                
                switch error {
                    
                case .some(let error):
                    print("Registration error: \(error.localizedDescription)")
                    SVProgressHUD.dismiss()
                    self.myAlert(title: "Error", message: "Description: \(error.localizedDescription)")
                    
                    
                case .none:
                    print("NO ERRORS")
                }

                
            }
                
                
            else{
                
                print("Registration Success")
                
                self.addUserData()
                
                self.performSegue(withIdentifier: "goToTerms", sender: self)
                
                
        SVProgressHUD.dismiss()
                
            
            }
            
            
        }
        
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
    
    


}
