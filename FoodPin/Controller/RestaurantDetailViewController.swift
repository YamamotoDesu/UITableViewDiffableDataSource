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
    
    @IBAction func rateRestaurant(seque: UIStoryboardSegue) {
        
        guard let identifier = seque.identifier else {
            return
        }
        
        dismiss(animated: true, completion: {
            
            if let rating = Restaurant.Rating(rawValue: identifier) {
                self.resutaurant.rating = rating
                self.headerView.ratingImgeView.image = UIImage(named: rating.image)
            }
            
            let scaleTransform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.headerView.ratingImgeView.transform = scaleTransform
            self.headerView.ratingImgeView.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.7, options: [], animations: {
                self.headerView.ratingImgeView.transform = .identity
                self.headerView.ratingImgeView.alpha = 1
            }, completion: nil)

        })
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
          navigationItem.backButtonDisplayMode = .minimal
        } else {
          navigationItem.backButtonTitle = " "
        }
        
        tableView.separatorEffect = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = true
        tableView.contentInsetAdjustmentBehavior = .never
        
        //Configure header view
        headerView.nameLabel.text = resutaurant.name
        headerView.typeLabel.text = resutaurant.type
        headerView.headerImageView.image = UIImage(data: resutaurant.image)
        
        let heartImage = resutaurant.isFavorite ? "heart.fill" : "heart"
        headerView.heartButton.tintColor = resutaurant.isFavorite ? .systemYellow : .white
        headerView.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMap":
            let destinationContoroller = segue.destination as! MapViewController
            
            destinationContoroller.restaurant = resutaurant
        case "showReview":
            let destinationContoroller = segue.destination as! ReviewViewController
            destinationContoroller.resutaurant = resutaurant
        default: break
        }
    }

}


extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailMapCell.self), for: indexPath) as! RestaurantDetailMapCell
            cell.configure(location: resutaurant.location)
            return cell
        default:
            fatalError("Failed to intstantiate the table view cell for detail view controller")
        }
    }
    
    
}
