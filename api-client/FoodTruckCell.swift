//
//  FoodTruckCell.swift
//  api-client
//
//  Created by user on 30/09/2017.
//  Copyright © 2017 David Kennedy. All rights reserved.
//

import UIKit

class FoodTruckCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var avgCostLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(truck: FoodTruck) {
        nameLabel.text = truck.name
        foodTypeLabel.text = truck.foodType
        avgCostLabel.text = "£\(truck.avgCost)"
    }

}
