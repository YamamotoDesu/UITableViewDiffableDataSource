//
//  ResutaurantDetailTwoCell.swift
//  FoodPin
//
//  Created by 山本響 on 2021/07/31.
//

import UIKit

class ResutaurantDetailTwoCell: UITableViewCell {

    @IBOutlet var column1TitleLabel: UILabel! {
        didSet {
            column1TitleLabel.text = column1TitleLabel.text?.uppercased()
            column1TitleLabel.numberOfLines = 0
            column1TitleLabel.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet var column1TextLabel: UILabel! {
        didSet {
            column1TextLabel.numberOfLines = 0
            column1TextLabel.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet var column2TitleLabel: UILabel! {
        didSet {
            column2TitleLabel.text = column2TitleLabel.text?.uppercased()
            column2TitleLabel.numberOfLines = 0
            column2TitleLabel.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet var column2TextLabel: UILabel! {
        didSet {
            column2TextLabel.numberOfLines = 0
            column2TextLabel.adjustsFontForContentSizeCategory = true
        }
    }
    

}
