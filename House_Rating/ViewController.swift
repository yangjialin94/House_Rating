//
//  ViewController.swift
//  House_Rating
//
//  Created by Jialin Yang on 11/1/16.
//  Copyright © 2016 YJL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        // Save for later if needed
    }
    
    // Action for logout button
    @IBAction func logoutButtonTapped(_ sender: AnyObject) {
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "login")
        self.present(controller!, animated: true, completion: nil)
    }
    
}

