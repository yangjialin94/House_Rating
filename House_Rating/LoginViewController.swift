//
//  LoginViewController.swift
//  House_Rating
//
//  Created by Jialin Yang on 11/1/16.
//  Copyright © 2016 YJL. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class LoginViewController: UIViewController {

    @IBOutlet var userEmailTextField: UITextField!
    @IBOutlet var userPasswordTextField: UITextField!
    
    var reference: FIRDatabaseReference! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        reference = FIRDatabase.database().reference()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action for login button
    @IBAction func loginButtonTapped(_ sender: AnyObject) {
        
        // Get user input
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        
        // Get user information from database
        if (userEmail != "" && userPassword != "") {
            FIRAuth.auth()?.signIn(withEmail: userEmail!, password: userPassword!, completion: { (user: FIRUser?, Error) in
               if Error == nil {

                self.performSegue(withIdentifier: "Home", sender: nil)
               }
            })
        }
        else {
            
            // Display an alert message for email or password incorrect
            displayMyAlertMessgae(userMessgae: "Email or Password is not correct")
            
            return;
        }
    }
    
    // Alert function
    func displayMyAlertMessgae(userMessgae: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: userMessgae, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
