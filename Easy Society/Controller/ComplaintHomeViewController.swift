//
//  ComplaintHomeViewController.swift
//  Easy Society
//
//  Created by Nitish on 4/24/19.
//  Copyright © 2019 Nitish. All rights reserved.
//

import UIKit

class ComplaintHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    
    
    
    
    
    @IBAction func readComplaintsPressed(_ sender: Any) {
        
       self.performSegue(withIdentifier: "goToComplaint", sender: self)
        
    }
    


}
