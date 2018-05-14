//
//  PARCommentViewController.swift
//  House_Rating
//
//  Created by Jialin Yang on 11/16/16.
//  Copyright © 2016 YJL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PARCommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var userInput: UITextField!
    @IBOutlet var tableView: UITableView!
    
    var comments = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get data from database
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("PAR Comment").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
            let comment = snapshot.value as! String
            self.comments.insert(comment, at: 0)
            self.tableView.reloadData()
        })
        
        print(self.comments)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Get number of cells
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (comments.count)
    }
    
    // Add information for cells
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! PARCommentTableViewCell
        
        cell.commentLabel.text = comments[indexPath.row]
        
        return (cell)
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        
        let comment = userInput.text
        
        if (comment?.isEmpty)! {
            
            displayMyAlertMessgae(userMessgae: "Please write something first")
            
            return
        }
        else {
            // Add to database
            let databaseRef = FIRDatabase.database().reference()
            databaseRef.child("PAR Comment").childByAutoId().setValue(comment)
            
            // Empty text field
            userInput.text = ""
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
