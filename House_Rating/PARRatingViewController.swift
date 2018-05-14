//
//  PARRatingViewController.swift
//  House_Rating
//
//  Created by Jialin Yang on 11/9/16.
//  Copyright © 2016 YJL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PARRatingViewController: UIViewController {

    @IBOutlet var dinningScore: UITextField!
    @IBOutlet var furnitureScore: UITextField!
    @IBOutlet var conveniencyScore: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        
        let inputDinningScore = dinningScore.text
        let inputFurnitureScore = furnitureScore.text
        let inputConveniencyScore = conveniencyScore.text
        
        // Check for emptyness
        if ((inputDinningScore?.isEmpty)! || (inputFurnitureScore?.isEmpty)! || (inputConveniencyScore?.isEmpty)!) {
            
            // Display alert message
            displayMyAlertMessgae(userMessgae: "All fields are required")
            
            return;
        }
        else if (numberCheck(num: Float(inputDinningScore!)!) != true || numberCheck(num: Float(inputFurnitureScore!)!) != true || numberCheck(num: Float(inputConveniencyScore!)!) != true) {
            
            // Display alert message
            displayMyAlertMessgae(userMessgae: "Numbers are not valid")
        }
        else {
            // Change string to float for inputs
            let inputDinningScore = Float(inputDinningScore!)
            let inputFurnitureScore = Float(inputFurnitureScore!)
            let inputConveniencyScore = Float(inputConveniencyScore!)
            
            // Create a dictionary
            let data : [String : Float] = ["DinningScore" : inputDinningScore!,
                                           "FurnitureScore" : inputFurnitureScore!,
                                           "ConveniencyScore" : inputConveniencyScore!]
            
            // Add to database
            let databaseRef = FIRDatabase.database().reference()
            databaseRef.child("PAR").childByAutoId().setValue(data)
        }
        
    }
    
    // Check if data is >=0 and <=5
    func numberCheck(num: Float) -> Bool {
        
        if (num >= 0 && num <= 5) {
            
            return true
        }
        else {
            return false
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
