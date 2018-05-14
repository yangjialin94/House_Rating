//
//  ApartmentListCellTableViewCell.swift
//  House_Rating
//
//  Created by Jialin Yang on 11/1/16.
//  Copyright © 2016 YJL. All rights reserved.
//

import UIKit

class ApartmentListCellTableViewCell: UITableViewCell {

    @IBOutlet var myImage: UIImageView!
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
