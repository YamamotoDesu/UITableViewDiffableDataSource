//
//  RestaurantDetailTextCell.swift
//  FoodPin
//
//  Created by 山本響 on 2021/07/31.
//

import UIKit

class RestaurantDetailTextCell: UITableViewCell {
    
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
        }
    }
}
