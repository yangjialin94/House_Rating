//
//  ApartmentListViewController.swift
//  House_Rating
//
//  Created by Jialin Yang on 11/1/16.
//  Copyright © 2016 YJL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ApartmentListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Array for dorm names
    let dorms = ["ISR", "LAR", "FAR", "PAR", "Ikenberry", "Allen Hall", "Busey-Evans"]
    
    // Get number of cells
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (dorms.count)
    }
    
    // Add information for cells
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ApartmentListCellTableViewCell
        
        cell.myImage.image = UIImage(named: (dorms[indexPath.row] + ".jpg"))
        cell.myLabel.text = dorms[indexPath.row]
        
        
        // Get score from data
        var totalDinningScore : Float = 0.0
        var totalFurnitureScore : Float = 0.0
        var totalConveniencyScore : Float = 0.0
        var count : Float = 0.0
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child(dorms[indexPath.row]).queryOrderedByKey().observe(.childAdded, with: { snapshot in
            
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
            cell.myScore.text = String(format: "%.1f", overall) + " / 5.0"
        })
        
        return (cell)
    }
    
    // Connect each cell with its view controller
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let controller = storyboard?.instantiateViewController(withIdentifier: "ISRInformation")
            self.present(controller!, animated: true, completion: nil)
        case 1:
            let controller = storyboard?.instantiateViewController(withIdentifier: "LARInformation")
            self.present(controller!, animated: true, completion: nil)
        case 2:
            let controller = storyboard?.instantiateViewController(withIdentifier: "FARInformation")
            self.present(controller!, animated: true, completion: nil)
        case 3:
            let controller = storyboard?.instantiateViewController(withIdentifier: "PARInformation")
            self.present(controller!, animated: true, completion: nil)
        case 4:
            let controller = storyboard?.instantiateViewController(withIdentifier: "IkenberryInformation")
            self.present(controller!, animated: true, completion: nil)
        case 5:
            let controller = storyboard?.instantiateViewController(withIdentifier: "AllenInformation")
            self.present(controller!, animated: true, completion: nil)
        case 6:
            let controller = storyboard?.instantiateViewController(withIdentifier: "BuseyInformation")
            self.present(controller!, animated: true, completion: nil)
        default:
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
