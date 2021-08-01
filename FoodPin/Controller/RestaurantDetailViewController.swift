//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by 山本響 on 2021/07/26.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: RestaurantDetailHeaderView!

    var resutaurant: Restaurant!
    
    var restaurantImageName = ""
    var restaurantName = ""
    var restaurantType = ""
    var restaurantLocation = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorEffect = .none
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationItem.backButtonTitle  = ""
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = true
        tableView.contentInsetAdjustmentBehavior = .never
        
        //Configure header view
        headerView.nameLabel.text = resutaurant.name
        headerView.typeLabel.text = resutaurant.type
        headerView.headerImageView.image = UIImage(named: resutaurant.image)
        
        let heartImage = resutaurant.isFavorite ? "heart.fill" : "heart"
        headerView.heartButton.tintColor = resutaurant.isFavorite ? .systemYellow : .white
        headerView.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}


extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailTextCell.self), for: indexPath) as! RestaurantDetailTextCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ResutaurantDetailTwoCell.self), for: indexPath) as! ResutaurantDetailTwoCell
            cell.column1TitleLabel.text = "Address"
            cell.column1TextLabel.text = resutaurant.location
            cell.column2TitleLabel.text = "Phone"
            cell.column2TextLabel.text = resutaurant.phone
            return cell
        default:
            fatalError("Failed to intstantiate the table view cell for detail view controller")
        }
    }
    
    
}
