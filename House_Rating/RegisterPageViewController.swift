//
//  RegisterPageViewController.swift
//  House_Rating
//
//  Created by Jialin Yang on 11/1/16.
//  Copyright © 2016 YJL. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class RegisterPageViewController: UIViewController {

    var ref: FIRDatabaseReference! = nil
    @IBOutlet var userEmailTextField: UITextField!
    @IBOutlet var userPasswordTextField: UITextField!
    @IBOutlet var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add reference
        ref = FIRDatabase.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action for register button
    @IBAction func registerButtonTapped(_ sender: AnyObject) {
        
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        // Check for empty fields
        if ((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)!) {
            
            // Display alert message for empty fields
            displayMyAlertMessgae(userMessgae: "All fields are required")
            
            return;
        }
        
        // Check for passwords match
        if (userPassword != userRepeatPassword) {
            
            // Display an alert message for incorrect passwords match
            displayMyAlertMessgae(userMessgae: "Passwords do not match")
            
            return;
        }
        
        // Get permission from firebase to add the user information into database
        FIRAuth.auth()!.createUser(withEmail: userEmail!, password: userPassword!, completion: { user, error in
            if error == nil {
                FIREmailPasswordAuthProvider.credential(withEmail: userEmail!, password: userPassword!)
                
                // Display alert message with confirmation for register
                let myAlert = UIAlertController(title: "Congradualtion!", message: "Registration Complete", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) {
                    action in self.dismiss(animated: true, completion: nil)
                }
                
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true, completion: nil)
                
            }
            else {
                
                //print(error?.localizedDescription)
                
                self.displayMyAlertMessgae(userMessgae: "User already exist.")
            }
        
        })

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
