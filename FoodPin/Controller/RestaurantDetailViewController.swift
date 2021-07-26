//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by 山本響 on 2021/07/26.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet var restaurantImageView: UIImageView!
    var restaurantImageName = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantImageView.image = UIImage(named: restaurantImageName)
    }

}
