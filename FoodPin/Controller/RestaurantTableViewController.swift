//
//  RestaurantTableTableViewController.swift
//  FoodPin
//
//  Created by 山本響 on 2021/07/24.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController {
    
    @IBOutlet var emptyRestaurantView: UIView!
    @IBOutlet weak var emptyImageView: UIImageView!
    
    var restaurants: [Restaurant] = []
    var fetchResultController: NSFetchedResultsController<Restaurant>!
    
    lazy var dataSource = configureDataSource()
    var isDynamicLargeType = false
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRestaurantData()
        
        // Prepare the empty view
        let emptyImage =  UITraitCollection.isDarkMode ? UIImage(named: "emptyblackdata") : UIImage(named: "emptydata")
        emptyImageView.image = emptyImage
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false : true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hidesBarsOnSwipe = true
        if #available(iOS 14.0, *) {
          navigationItem.backButtonDisplayMode = .minimal
        } else {
          navigationItem.backButtonTitle = " "
        }
        
        tableView.separatorStyle = .none
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        //Assign the diffable data source to your table view.
        tableView.dataSource = dataSource
        
        //Generate the current state of the table data by creating a snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        
        //Call the apply() function of the data source to populate the data
        dataSource.apply(snapshot, animatingDifferences: false)
        
        // To customize the navigation bar, you first need to retrieve the currentUINavigationBarAppearance object
        // The standardAppearance property contains thecurrent appearance settings for the standard size navigation bar
        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {

                appearance.titleTextAttributes = [.foregroundColor:
                                                    UIColor(named: "NavigationBarTitle")!, .font: customFont]
                appearance.largeTitleTextAttributes = [.foregroundColor:
                                                        UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // perform action here when user changes the text size
        switch self.traitCollection.preferredContentSizeCategory {
        case .extraExtraLarge, .extraExtraExtraLarge, .accessibilityExtraLarge, .accessibilityExtraExtraLarge, .accessibilityExtraExtraExtraLarge:
            self.isDynamicLargeType = true
        case .extraSmall, .small, .medium, .accessibilityMedium, .large, .extraLarge:
            self.isDynamicLargeType = false
        default:
            self.isDynamicLargeType = false
        }
        
        // reload view here when user changes the text size
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            self.dataSource = configureDataSource()
            self.viewDidLoad()
        }
        
    }
    
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant> {
        let cellIdentifier = self.isDynamicLargeType ? "datacell" : "favoritecell"
        //Create a UITableViewDiffableDataSource object to connect with your table andprovide the configuration of the table view cells.
        let dataSource = RestaurantDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, restaurant in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                cell.nameLabel.text = restaurant.name
                cell.thumbnailImageView.image = UIImage(data: restaurant.image)
                cell.locationLabel.text = restaurant.location
                cell.typeLabel.text = restaurant.type
                cell.heartMark.isHidden = !self.restaurants[indexPath.row].isFavorite
                cell.heartMark.tintColor = UITraitCollection.isDarkMode ? .systemYellow : .blue
                return cell
                
            }
        )
        return dataSource
        
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        let reserveActionHandler = { (action:UIAlertAction!) -> Void in
    //            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. Please retry later.", preferredStyle: .alert)
    //            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //            self.present(alertMessage, animated: true, completion: nil)
    //        }
    //
    //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    //        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
    //
    //
    //        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
    //        if let popoverController = optionMenu.popoverPresentationController {
    //            if let cell = tableView.cellForRow(at: indexPath) {
    //                popoverController.sourceView = cell
    //                popoverController.sourceRect = cell.bounds
    //            }
    //        }
    //
    //        let isFavoriteMark = self.restaurantIsFavorites[indexPath.row]
    //        let favoriteTitle = !isFavoriteMark ? "Mark as favorite" : "Remove from favorites"
    //
    //        let favoriteAction = UIAlertAction(title: favoriteTitle, style: .default, handler: { (action: UIAlertAction!) -> Void in
    //            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
    //            cell.heartMark.isHidden = !isFavoriteMark
    //            cell.heartMark.tintColor = UITraitCollection.isDarkMode ? .systemYellow : .blue
    //            self.restaurantIsFavorites[indexPath.row] = !isFavoriteMark
    //            tableView.reloadData()
    //        })
    //
    //        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
    //        optionMenu.addAction(reserveAction)
    //
    //        optionMenu.addAction(favoriteAction)
    //        optionMenu.addAction(cancelAction)
    //
    //        self.present(optionMenu, animated: true, completion: nil)
    //    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        // Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
            // Call completion handler to dismiss tbe action button
            completionHandler(true)
        }
        
        //Share action
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Just checking in at " + restaurant.name
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(data: restaurant.image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            // For iPad
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                    
                }
            }
            
            self.present(activityController, animated: false, completion: nil)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        // Configure both actions as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        // Favorite action
        let favoriteAction = UIContextualAction(style: .normal, title: "") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantTableViewCell
            cell.heartMark.isHidden = !restaurant.isFavorite
            cell.heartMark.tintColor = UITraitCollection.isDarkMode ? .systemYellow : .blue
            self.restaurants[indexPath.row].isFavorite = !restaurant.isFavorite
            tableView.reloadData()
            
            // Call completion handler to dismiss tbe action button
            completionHandler(true)
        }
        
        favoriteAction.backgroundColor = UIColor.systemYellow
        favoriteAction.image = UIImage(systemName: "heart.fill")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return swipeConfiguration
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showRestaurantData" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.resutaurant = self.restaurants[indexPath.row]
            }
        }
    }
    
    func fetchRestaurantData() {
        // Fetch data from data store
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        ()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                updateSnapshot()
            } catch {
                print(error)
            }
        }
      
    }
    
    func updateSnapshot(animatetingChange: Bool = false) {
        
        if let fetchedObjects = fetchResultController.fetchedObjects {
            restaurants = fetchedObjects
        }
        
        // Create a anapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        dataSource.apply(snapshot, animatingDifferences: animatetingChange)
        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false : true
        
    }
}

extension RestaurantTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateSnapshot()
    }
}
