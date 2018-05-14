//
//  PARPhotoViewController.swift
//  House_Rating
//
//  Created by Jialin Yang on 11/30/16.
//  Copyright © 2016 YJL. All rights reserved.
//

import UIKit
import Firebase

class PARPhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        // Get names from database and get images from storage
        let databaseRef = FIRDatabase.database().reference()
        let storage = FIRStorage.storage()
        let storageRef = storage.reference()
        
        databaseRef.child("PAR Images").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
            let name = snapshot.value as! String
            let imageRef = storageRef.child("PAR Images").child(name)
            
            imageRef.data(withMaxSize: 1024 * 1024 * 1024) { (data, error) -> Void in
                
                if (error != nil) {
                    print(error!)
                }
                else {
                    // Create a UIImage, add it to the array
                    let img = UIImage(data: data!)
                    self.images.insert(img!, at: 0)
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Get number of cells
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (images.count)
    }
    
    // Add information for cells
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PARPhotoTableViewCell
        
        cell.myImage.image = images[indexPath.row]
        
        return (cell)
        
    }
    
    @IBAction func addImage(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get Image
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageName = NSUUID().uuidString
        dismiss(animated: true, completion: nil)
        
        // Upload Image to storage
        let storageRef = FIRStorage.storage().reference().child("PAR Images")
        let uploadData = UIImagePNGRepresentation(selectedImage)
        
        storageRef.child("\(imageName).png").put(uploadData!, metadata: nil) { metadata, error in
            
            if (error != nil) {
                self.displayMyAlertMessgae(userMessgae: "Error")
            }
        }
        
        // Upload Image name to database
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child("PAR Images").childByAutoId().setValue("\(imageName).png")
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
