//
//  ComplaintViewController.swift
//  Easy Society
//
//  Created by Nitish on 4/24/19.
//  Copyright © 2019 Nitish. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ComplaintViewController: UIViewController, UITextFieldDelegate,UITextViewDelegate {
    
    
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var complaintBox: UITextView!
    @IBOutlet var postButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicTextField.delegate = self
        complaintBox.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        topicTextField.resignFirstResponder()
        
        
        return true
        
        
    }
    
    
    
    
    
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        topicTextField.endEditing(true)
        complaintBox.endEditing(true)
        
        topicTextField.isEnabled = false
        complaintBox.isEditable = false
        
        postButton.isEnabled = false
        
        let complaintDB = Database.database().reference().child("Complaints")
        
        let complaintDictionary = ["Sender" : Auth.auth().currentUser?.email, "Topic" : topicTextField.text!, "Complaint" : complaintBox.text! ]
        
        complaintDB.childByAutoId().setValue(complaintDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            }
            else{
                print("Complaint Recieved")
                
                SVProgressHUD.dismiss()
                
                self.myAlert(title: "Complaint Posted", message: "Your complaint has been posted succesfully")
                
                self.topicTextField.isEnabled = true
                self.postButton.isEnabled = true
                self.complaintBox.isEditable = true
                self.complaintBox.text = ""
                self.topicTextField.text = ""
                
                
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
