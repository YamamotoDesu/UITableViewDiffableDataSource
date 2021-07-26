//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by 山本響 on 2021/07/24.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var heartMark: UIImageView!
    @IBOutlet var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = 20
            thumbnailImageView.clipsToBounds = true
            }
    }

    override class func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.heartMark.tintColor = UITraitCollection.isDarkMode ? .systemYellow : .systemPink
    }
}
