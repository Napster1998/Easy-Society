//
//  HomePageViewController.swift
//  Easy Society
//
//  Created by Nitish on 4/24/19.
//  Copyright © 2019 Nitish. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func chatPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToChat", sender: self)
        
    }
    
    ////////////////////////////////////////////
    //    MARK :- Logging out code
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        
//        do {
//
//            myAlert(title: "Confirm Logout", message: "Are you sure you want to logout?")
//
//            try Auth.auth().signOut()
//            print("Logout successful")
//            navigationController?.popViewController(animated: true)
//
//            //navigationController?.performSegue(withIdentifier: "goToWelcomePage", sender: self)
//
//        }
//        catch{
//            print("Error in logging out")
//        }
        
        
        myAlert(title: "Confirm Logout", message: "Are you sure you want to logout?")
        
        
        
        
    }
    
    func myAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //That is one button
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            self.logOutProcedure()
            
            
        }))
        
        //This is another button
        alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            
        }))
        
        
        self.present(alert, animated: true , completion: nil)
        
    }
    
    func retryLogoutButton(title:String){
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: UIAlertController.Style.alert)
        
        //This is the retry button
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            self.logOutProcedure()
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancle", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
    }
    
    
    //Logs the user out
    func logOutProcedure() {
        
//            let firebaseAuth = Auth.auth()
//        do{
//
//                try firebaseAuth.signOut()
//                print("Logout successful")
//                //navigationController?.popViewController(animated: true)
//                navigationController?.popToRootViewController(animated: true)
//            }
//            catch let signOutError as NSError {
//
//                print("Error Signing out", signOutError)
//
//                retryLogoutButton(title: "Failed to Logout")
//
//            }
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            print("Logout Successful")
            navigationController?.popToRootViewController(animated: true)
        }
        catch let logoutError{
            print("Error signing out\(logoutError.localizedDescription)")
            myAlert(title: "Error", message: "Description\(logoutError.localizedDescription)")
        }
        
        
        }
    
    
}
