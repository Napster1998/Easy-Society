//
//  ChatViewController.swift
//  Easy Society
//
//  Created by Nitish on 4/24/19.
//  Copyright © 2019 Nitish. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    var messageArray : [Message] = [Message]()
    
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
            override func viewDidLoad() {
        super.viewDidLoad()
                
                messageTableView.delegate = self
                messageTableView.dataSource = self
                messageTextField.delegate = self
                
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
                messageTableView.addGestureRecognizer(tapGesture)
                
                
                messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
                
                configureTableView()
                retrieveMessages()
                
                messageTableView.separatorStyle = .none
                
            

        
    }
    //////////////////////////////////////////
    
    //    MARK:- TableView DataSource Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email as String? {
            //Our own message
            cell.avatarImageView.backgroundColor = UIColor.flatBlue()
            cell.messageBackground.backgroundColor = UIColor.flatWatermelon()
            
        }
        else {
            cell.avatarImageView.backgroundColor = UIColor.flatRed()
            cell.messageBackground.backgroundColor = UIColor.flatGreen()
        }
        
        return cell
    
    }
    
//    Table View Tapped Here
    @objc func tableViewTapped() {
        messageTextField.endEditing(true)
    }
    
    
    
    
    
    // MARK:- Number of Rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageArray.count
        
    }
    
    //    MARK:- TextField Delegate Method
    //    Text Field began editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        UIView.animate(withDuration: 1) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
            }
        
    }
    
    
    //    Text Field Ended editing
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 1) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    
    
    //     MARK:- Resizing the Table View
    
    func configureTableView() {
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextField.endEditing(true)
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,"MessageBody":messageTextField.text!]
        
        messagesDB.childByAutoId().setValue(messageDictionary) {
            (error,reference) in
            
            if error != nil {
                
                switch error {
                    
                case .some(let error):
                    print("Network error: \(error.localizedDescription)")
                    
                    self.myAlert(title: "Error", message: "Description: \(error.localizedDescription)")
                    
                    
                case .none:
                    print("NO ERRORS")
                }
                
            }
            else{
                print("Message Saved")
                
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
                
            }
        }
        
    }
    
    //    MARK:- Retrieve Messages
    
    func retrieveMessages() {
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            
           let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            print(text,sender)
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            
            self.configureTableView()
            self.messageTableView.reloadData()
            
    
        }
        
        
    }
    
    
    
    
    
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToHomePage", sender: self)
        
        
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
