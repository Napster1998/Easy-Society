//
//  ComplaintTableViewController.swift
//  Easy Society
//
//  Created by Nitish on 4/24/19.
//  Copyright © 2019 Nitish. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ComplaintTableViewController: UIViewController,UITableViewDelegate,UITextFieldDelegate,UITableViewDataSource {
    
    var complaintArray : [Complaint] = [Complaint]()
    

    @IBOutlet var complaintTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        complaintTableView.delegate = self
        complaintTableView.dataSource = self
        
    
    
        
        complaintTableView.register(UINib(nibName: "CustomComplaintBox", bundle: nil), forCellReuseIdentifier: "customComplaintBox")
        
        configureTableView()
        retrieveComplaints()
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customComplaintBox", for: indexPath) as! CustomComplaintBox
        
        cell.complaintBody.text = complaintArray[indexPath.row].complaintBody
        cell.complaintTopic.text = complaintArray[indexPath.row].complaintTopic
        cell.senderUsername.text = complaintArray[indexPath.row].sender
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email as String? {
            //Messages we send as ourself
            
            cell.complaintBackground.backgroundColor = UIColor.flatLime()
        }
            
        else {
            cell.complaintBackground.backgroundColor = UIColor.flatRed()
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return complaintArray.count
        
    }
    
    func configureTableView() {
        
        complaintTableView.rowHeight = UITableView.automaticDimension
        complaintTableView.estimatedRowHeight = 120.0
        
    }
    
    func retrieveComplaints() {
        
        let complaintDB = Database.database().reference().child("Complaints")
        
        complaintDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let text = snapshotValue["Complaint"]!
            let topic = snapshotValue["Topic"]!
            let sender = snapshotValue["Sender"]!
            
            print(text, sender, topic)
            
            let complaint = Complaint()
            complaint.complaintBody = text
            complaint.complaintTopic = topic
            complaint.sender = sender
            
            self.complaintArray.append(complaint)
            
            self.configureTableView()
            self.complaintTableView.reloadData()
            
        }
    
    }
    



}
