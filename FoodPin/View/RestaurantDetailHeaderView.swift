//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by 山本響 on 2021/07/31.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
            
            if let cutomFont = UIFont(name: "Nunito-Bold", size: 40.0) {
                nameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: cutomFont)
            }
        }
    }
    @IBOutlet var typeLabel: UILabel! {
        didSet {
            if let cutomFont = UIFont(name: "Nunito-Bold", size: 20.0) {
                typeLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: cutomFont)
            }
        }
    }
    @IBOutlet var heartButton: UIButton!
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.heartButton.tintColor = UITraitCollection.isDarkMode ? .systemYellow : .systemPink
    }

}
