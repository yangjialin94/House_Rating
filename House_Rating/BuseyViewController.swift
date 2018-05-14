//
//  BuseyViewController.swift
//  House_Rating
//
//  Created by Jialin Yang on 11/9/16.
//  Copyright © 2016 YJL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class BuseyViewController: UIViewController {

    @IBOutlet var dormImage: UIImageView!
    @IBOutlet var overallScore: UILabel!
    @IBOutlet var dinningScore: UILabel!
    @IBOutlet var furnitureScore: UILabel!
    @IBOutlet var conveniencyScore: UILabel!
    
    // Load image and scores
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Variables
        var totalDinningScore : Float = 0.0
        var totalFurnitureScore : Float = 0.0
        var totalConveniencyScore : Float = 0.0
        var count : Float = 0.0
        
        // Get data from database
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Busey-Evans").queryOrderedByKey().observe(.childAdded, with: { snapshot in
            
            let snapshotValue = snapshot.value as! [String: Float]
            let dinning = snapshotValue["DinningScore"]! as Float
            let furniture = snapshotValue["FurnitureScore"]! as Float
            let convenience = snapshotValue["ConveniencyScore"]! as Float
            
            totalDinningScore += dinning
            totalFurnitureScore += furniture
            totalConveniencyScore += convenience
            count += 1
            
            print(totalDinningScore)
            print(totalFurnitureScore)
            print(totalConveniencyScore)
            print(count)
            
            let overall = (totalDinningScore + totalFurnitureScore + totalConveniencyScore) / count / 3.0
            let dScore = totalDinningScore / count
            let fScore = totalFurnitureScore / count
            let cScore = totalConveniencyScore / count
            let num = Int(count)
            
            self.overallScore.text = "Overall: " + String(format: "%.1f", overall) + " Out of " + String(num) + " Vote(s)"
            self.dormImage.image = UIImage(named: "ISR.jpg")
            self.dinningScore.text = "Busey-Evans: " + String(format: "%.2f", dScore) + " / 5.0"
            self.furnitureScore.text = "Furniture: " + String(format: "%.2f", fScore) + " / 5.0"
            self.conveniencyScore.text = "Conveniency: " + String(format: "%.2f", cScore) + " / 5.0"
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
